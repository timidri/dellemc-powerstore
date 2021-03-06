require 'puppet/resource_api'

# rubocop:disable Style/StringLiterals
Puppet::ResourceApi.register_type(
  name: 'powerstore_migration_session',
  features: ['remote_resource'],
  # rubocop:disable Lint/UnneededDisable
  # rubocop:disable Layout/TrailingWhitespace
  desc: <<-EOS,
    Manage migration sessions.
  EOS
  attributes:   {
    ensure:      {
      type:      "Enum['present', 'absent']",
      desc:      'Whether this resource should be present or absent on the target system.',
      default:   'present',
    },
    automatic_cutover:          {
      type:      "Optional[Boolean]",
      desc:      "Indicates whether the migration session cutover is manual or automatic. Default for virtual_volume resource type migrations is automatic, otherwise the default is manual.",
      behaviour: :init_only,
    },
    destination_appliance_id:          {
      type:      "Optional[String]",
      desc:      "Unique identifier of the destination appliance instance.",
      behaviour: :init_only,
    },
    family_id:          {
      type:      "Optional[String]",
      desc:      "Family identifier designating the storage resource or resources to migrate. For volume or virtual_volume migrations, the family is moved together because they share data among the primary object, snapshots, and clones. For volume_group migration, the family of each volume in the group is moved because it is a grouping of volumes.",
      behaviour: :init_only,
    },
    force:          {
      type:      "Optional[Boolean]",
      desc:      "Indicates whether all migration activities will be canceled before deleting the session.",
      behaviour: :parameter,
    },
    name:          {
      type:      "Optional[String]",
      desc:      "User-specified friendly name of the migration session instance. The name can contain a maximum of 32 Unicode characters. It cannot contain unprintable characters, special HTTP characters, or whitespace.",
      behaviour: :namevar,
    },
    resource_type:          {
      type:      "Optional[Enum['volume','virtual_volume','volume_group']]",
      desc:      "Storage resource types eligible for migration.",
      behaviour: :init_only,
    },
  },
  autorequires: {
    file:    '$source', # will evaluate to the value of the `source` attribute
    package: 'apt',
  },
)
