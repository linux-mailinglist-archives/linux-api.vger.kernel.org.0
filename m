Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3D3D293E58
	for <lists+linux-api@lfdr.de>; Tue, 20 Oct 2020 16:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407844AbgJTOLt (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 20 Oct 2020 10:11:49 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47517 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407825AbgJTOLt (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 20 Oct 2020 10:11:49 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kUsMP-0007A4-Cn; Tue, 20 Oct 2020 14:11:33 +0000
Date:   Tue, 20 Oct 2020 16:11:32 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        containers@lists.linux-foundation.org,
        Alexander Mihalicyn <alexander@mihalicyn.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Joseph Christopher Sible <jcsible@cert.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Andy Lutomirski <luto@amacapital.net>,
        =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
        Wat Lim <watl@google.com>, Mrunal Patel <mpatel@redhat.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-api@vger.kernel.org
Subject: Re: [RFC][PATCH] userns: Limit process in a user namespace to what
 the creator is allowed
Message-ID: <20201020141132.7xcfallevp4kiv45@wittgenstein>
References: <20200830143959.rhosiunyz5yqbr35@wittgenstein>
 <cb6c6f1a-89ee-1762-3eec-4f69bd7739b1@metux.net>
 <874kmsdcdx.fsf@x220.int.ebiederm.org>
 <20201018102026.34jtxfheygowgejp@wittgenstein>
 <87h7qradml.fsf_-_@x220.int.ebiederm.org>
 <87o8kz840w.fsf@x220.int.ebiederm.org>
 <878sc27zfd.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <878sc27zfd.fsf_-_@x220.int.ebiederm.org>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Oct 19, 2020 at 03:07:02PM -0500, Eric W. Biederman wrote:
> Ordinary unix permissions and posix acls have the ability to
> expression that processes show uid or gid match have fewer permissions
> than processes without matches that use the other permissions.

I'm stumbling a bit reading that sentence but that may just me parsing
it wrong:

"[...] have the ability to express that processes whose uid or gid match
nonetheless have fewer permissions than processes without matching uid
or gid that use other permissions."

is how I'm understanding this.

> 
> The fact a root user in a user namespace can call setgroups and setuid
> allows these restrictive permissions to be avoided.  To limit the problems
> this can cause populationg the the set of uids that can be switched to,
> and the set of gids that can be switched to is an operation that requires
> priviliege outside of the user namespace.
> 
> This restriction is currently being reexamined as it appears that
> there is a way to implement uids and gids that do not map outside of
> the user namespace.  Such uids and gids would not require privilege
> from outside of the usernamespace to use.  So it becomes important to
> find a way to allow calling setuid and setgroups in a user namespace
> without allowing processes in a user namespace to do more than the
> creator of the user namespace.
> 
> To that end capture the groups set with setgroups of the creator of a
> user_namespace.  Update the affected permission checks to notice when
> something is being allowed with other permissions and only allow the
> operation if the creator of the user namespace does not have a user or
> group match that would disallow the operation.
> 
> The goal is to ensure that creating a user namespace and allowing
> the user namespace root to setuid and setgroups does not result
> in being permitted to do more than before the user namespace was
> created, while still supporting explicitly specified users and
> groups to have fewer permissions.
> 
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> ---
> 
> So far only generic_permission is covered, but I think this demonstrates
> that the goal is achievable.  Preserving negative acls while allowing
> setuid and setgroups.

I think that looks good. I have run our test-suite with this patch
applied and it survived no problem so I don't see any regressions for
current use-cases so far.

> 
>  fs/namei.c                     |  7 +++++
>  fs/posix_acl.c                 | 51 ++++++++++++++++++++++++++++++++++
>  include/linux/user_namespace.h | 16 +++++++++++
>  kernel/user_namespace.c        | 29 +++++++++++++++++++
>  4 files changed, 103 insertions(+)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index e99e2a9da0f7..ca06bd81d4e4 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -322,6 +322,13 @@ static int acl_permission_check(struct inode *inode, int mask)
>  	if (mask & (mode ^ (mode >> 3))) {
>  		if (in_group_p(inode->i_gid))
>  			mode >>= 3;
> +		/*
> +		 * Only allow the intersection of what the creator of
> +		 * the user namespace is allowed and what everyone is
> +		 * allowed.
> +		 */
> +		else if (userns_in_group_p(inode->i_sb->s_user_ns, inode->i_gid))
> +			mode &= (mode >> 3);
>  	}
>  
>  	/* Bits in 'mode' clear that we require? */
> diff --git a/fs/posix_acl.c b/fs/posix_acl.c
> index 95882b3f5f62..525803f8f70c 100644
> --- a/fs/posix_acl.c
> +++ b/fs/posix_acl.c
> @@ -340,6 +340,53 @@ posix_acl_from_mode(umode_t mode, gfp_t flags)
>  }
>  EXPORT_SYMBOL(posix_acl_from_mode);
>  
> +static bool userns_creator_allowed(struct inode *inode,
> +				   const struct posix_acl *acl, int want)
> +{
> +	/* Don't allow access the creator of the user namespace does not have */
> +	struct user_namespace *ns = inode->i_sb->s_user_ns;
> +	const struct posix_acl_entry *pa, *pe;
> +	unsigned short min_perm;
> +	bool found = false;
> +
> +	min_perm = MAY_READ | MAY_WRITE | MAY_EXEC;
> +	FOREACH_ACL_ENTRY(pa, acl, pe) {
> +                switch(pa->e_tag) {
> +                        case ACL_USER_OBJ:
> +				/* No need to limit the owner of a file */
> +                                break;
> +                        case ACL_USER:
> +				if (is_userns_creator(ns, pa->e_uid)) {
> +					found = true;
> +					min_perm &= pa->e_perm;
> +				}
> +				break;
> +                        case ACL_GROUP_OBJ:
> +				if (userns_in_group_p(ns, inode->i_gid)) {
> +					found = true;
> +					min_perm &= pa->e_perm;
> +				}
> +				break;
> +                        case ACL_GROUP:
> +				if (userns_in_group_p(ns, pa->e_gid)) {
> +					found = true;
> +					min_perm &= pa->e_perm;
> +				}
> +                                break;
> +                        case ACL_MASK:
> +				if (found)
> +					min_perm &= pa->e_perm;
> +                                break;
> +                        case ACL_OTHER:
> +				if (found &&
> +				    ((pa->e_perm & want & min_perm) != want))
> +					return false;
> +				return true;
> +                }
> +        }
> +	return false;
> +}
> +
>  /*
>   * Return 0 if current is granted want access to the inode
>   * by the acl. Returns -E... otherwise.
> @@ -382,6 +429,10 @@ posix_acl_permission(struct inode *inode, const struct posix_acl *acl, int want)
>                          case ACL_OTHER:
>  				if (found)
>  					return -EACCES;
> +				else if ((current_user_ns() != inode->i_sb->s_user_ns) &&
> +					 ((pa->e_perm & want) == want) &&
> +					 userns_creator_allowed(inode, acl, want))
> +					return 0;
>  				else
>  					goto check_perm;
>  			default:
> diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
> index 6ef1c7109fc4..b4bcb49bed7a 100644
> --- a/include/linux/user_namespace.h
> +++ b/include/linux/user_namespace.h
> @@ -62,6 +62,7 @@ struct user_namespace {
>  	int			level;
>  	kuid_t			owner;
>  	kgid_t			group;
> +	struct group_info 	*groups;
>  	struct ns_common	ns;
>  	unsigned long		flags;
>  
> @@ -137,6 +138,10 @@ extern bool in_userns(const struct user_namespace *ancestor,
>  		       const struct user_namespace *child);
>  extern bool current_in_userns(const struct user_namespace *target_ns);
>  struct ns_common *ns_get_owner(struct ns_common *ns);
> +
> +bool is_userns_creator(struct user_namespace *ns, kuid_t uid);
> +bool userns_in_group_p(struct user_namespace *ns, kgid_t group);
> +
>  #else
>  
>  static inline struct user_namespace *get_user_ns(struct user_namespace *ns)
> @@ -181,6 +186,17 @@ static inline struct ns_common *ns_get_owner(struct ns_common *ns)
>  {
>  	return ERR_PTR(-EPERM);
>  }
> +
> +static inline bool is_userns_creator(struct user_namespace *ns, kuid_t uid)
> +{
> +	return false;
> +}
> +
> +static inline bool userns_in_group_p(struct user_namespace *ns, kgid_t group)
> +{
> +	return false;
> +}
> +
>  #endif
>  
>  #endif /* _LINUX_USER_H */
> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> index 87804e0371fe..8a4949a32e36 100644
> --- a/kernel/user_namespace.c
> +++ b/kernel/user_namespace.c
> @@ -117,6 +117,7 @@ int create_user_ns(struct cred *new)
>  	ns->level = parent_ns->level + 1;
>  	ns->owner = owner;
>  	ns->group = group;
> +	ns->groups = get_group_info(new->group_info);
>  	INIT_WORK(&ns->work, free_user_ns);
>  	for (i = 0; i < UCOUNT_COUNTS; i++) {
>  		ns->ucount_max[i] = INT_MAX;
> @@ -143,6 +144,7 @@ int create_user_ns(struct cred *new)
>  	key_put(ns->persistent_keyring_register);
>  #endif
>  	ns_free_inum(&ns->ns);
> +	put_group_info(ns->groups);
>  fail_free:
>  	kmem_cache_free(user_ns_cachep, ns);
>  fail_dec:
> @@ -194,6 +196,7 @@ static void free_user_ns(struct work_struct *work)
>  		retire_userns_sysctls(ns);
>  		key_free_user_ns(ns);
>  		ns_free_inum(&ns->ns);
> +		put_group_info(ns->groups);
>  		kmem_cache_free(user_ns_cachep, ns);
>  		dec_user_namespaces(ucounts);
>  		ns = parent;
> @@ -1317,6 +1320,32 @@ const struct proc_ns_operations userns_operations = {
>  	.get_parent	= ns_get_owner,
>  };
>  
> +bool is_userns_creator(struct user_namespace *target_ns, kuid_t uid)
> +{
> +	struct user_namespace *user_ns = current_user_ns();
> +
> +	for (user_ns = current_user_ns();
> +	     (user_ns != target_ns) && user_ns;
> +	     user_ns = user_ns->parent) {
> +		if (uid_eq(uid, user_ns->owner))
> +			return true;
> +	}
> +	return false;
> +}
> +
> +bool userns_in_group_p(struct user_namespace *target_ns, kgid_t group)
> +{
> +	struct user_namespace *user_ns;
> +
> +	for (user_ns = current_user_ns();
> +	     (user_ns != target_ns) && user_ns;
> +	     user_ns = user_ns->parent) {
> +		if (groups_search(user_ns->groups, group))
> +			return true;
> +	}
> +	return false;
> +}
> +
>  static __init int user_namespaces_init(void)
>  {
>  	user_ns_cachep = KMEM_CACHE(user_namespace, SLAB_PANIC);
> -- 
> 2.20.1
