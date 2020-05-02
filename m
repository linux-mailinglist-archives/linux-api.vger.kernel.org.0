Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA71E1C2652
	for <lists+linux-api@lfdr.de>; Sat,  2 May 2020 16:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgEBOz0 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 2 May 2020 10:55:26 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:52984 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728025AbgEBOz0 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 2 May 2020 10:55:26 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jUtY4-00054T-MN; Sat, 02 May 2020 08:55:24 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jUtY2-0001OS-Uz; Sat, 02 May 2020 08:55:24 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Jann Horn <jannh@google.com>, linux-api@vger.kernel.org,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <20200430165717.1001605-1-christian.brauner@ubuntu.com>
        <87y2qczvz9.fsf@x220.int.ebiederm.org>
        <20200501154251.j4iuz42tntnjcvaa@wittgenstein>
        <874ksytsye.fsf@x220.int.ebiederm.org>
        <20200502143243.ip4ayr35afdykvyb@wittgenstein>
Date:   Sat, 02 May 2020 09:52:03 -0500
In-Reply-To: <20200502143243.ip4ayr35afdykvyb@wittgenstein> (Christian
        Brauner's message of "Sat, 2 May 2020 16:32:43 +0200")
Message-ID: <87a72qs830.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jUtY2-0001OS-Uz;;;mid=<87a72qs830.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+l+mj2NDOkTQN7xzVp65cvLKHm+PLdbBA=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,T_TooManySym_03 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4992]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Christian Brauner <christian.brauner@ubuntu.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1208 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (0.9%), b_tie_ro: 9 (0.8%), parse: 1.22 (0.1%),
         extract_message_metadata: 16 (1.3%), get_uri_detail_list: 6 (0.5%),
        tests_pri_-1000: 4.7 (0.4%), tests_pri_-950: 1.24 (0.1%),
        tests_pri_-900: 1.04 (0.1%), tests_pri_-90: 190 (15.7%), check_bayes:
        188 (15.6%), b_tokenize: 19 (1.6%), b_tok_get_all: 76 (6.3%),
        b_comp_prob: 4.4 (0.4%), b_tok_touch_all: 84 (7.0%), b_finish: 1.03
        (0.1%), tests_pri_0: 666 (55.2%), check_dkim_signature: 0.68 (0.1%),
        check_dkim_adsp: 2.2 (0.2%), poll_dns_idle: 295 (24.4%), tests_pri_10:
        1.99 (0.2%), tests_pri_500: 311 (25.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 1/4] capability: add ns_capable_cred()
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Christian Brauner <christian.brauner@ubuntu.com> writes:

> On Sat, May 02, 2020 at 07:35:53AM -0500, Eric W. Biederman wrote:
>> Christian Brauner <christian.brauner@ubuntu.com> writes:
>> 
>> > On Thu, Apr 30, 2020 at 01:09:30PM -0500, Eric W. Biederman wrote:
>> >> Christian Brauner <christian.brauner@ubuntu.com> writes:
>> >> 
>> >> > Add a simple capability helper which makes it possible to determine
>> >> > whether a set of creds is ns capable wrt to the passed in credentials.
>> >> > This is not something exciting it's just a more pleasant wrapper around
>> >> > security_capable() by allowing ns_capable_common() to ake a const struct
>> >> > cred argument. In ptrace_has_cap() for example, we're using
>> >> > security_capable() directly. ns_capable_cred() will be used in the next
>> >> > patch to check against the target credentials the caller is going to
>> >> > switch to.
>> >> 
>> >> Given that this is to suppot setns.  I don't understand the
>> >> justification for this.
>> >> 
>> >> Is it your intention to use the reduced permissions that you get
>> >> when you install a user namespace?
>> >
>> > Indeed.
>> >
>> >> 
>> >> Why do you want to use the reduced permissions when installing multiple
>> >> namespaces at once?
>> >
>> > The intention is to use the target credentials we are going to install
>> > when setns() hits the point of no return. The target permissions are
>> > either the permissions of the caller or the reduced permissions if
>> > CLONE_NEWUSER has been requested. This has multiple reasons.
>> >
>> > The most obvious reason imho is that all other namespaces have an owning
>> > user namespace. Attaching to any other namespace requires the attacher
>> > to be privileged over the owning user namespace of that namespace.
>> > Consequently, all our current install handlers for every namespace we
>> > have check whether we are privileged in the owning user namespace of
>> > that user namespace. So in order to attach to any of those namespaces -
>> > especially when attaching as an unprivileged user - requires that we are
>> > attached to the user namespace first.
>> 
>> No actually it doesn't.  As if you have privileges to attach to the user
>> namespace you have the privileges to attach to anything it owns.  Or you
>> should I think I am missing some subtle detail at the moment.
>
> Sorry, I phrased that very misleadingly. What I'm talking about should
> be obvious in the second patch:
>
> -static int utsns_install(struct nsproxy *nsproxy, struct ns_common *new)
> +static int utsns_install(struct nsset *nsset, struct ns_common *new)
>  {
> +       struct nsproxy *nsproxy = nsset->nsproxy;
>         struct uts_namespace *ns = to_uts_ns(new);
>
> -       if (!ns_capable(ns->user_ns, CAP_SYS_ADMIN) ||
> -           !ns_capable(current_user_ns(), CAP_SYS_ADMIN))
> +       if (!ns_capable_cred(nsset->cred, ns->user_ns, CAP_SYS_ADMIN) ||
> +           !ns_capable_cred(nsset->cred, nsset->cred->user_ns, CAP_SYS_ADMIN))
>                 return -EPERM;
>
> All our current install handlers check that we're privileged wrt to our
> _current_ user namespace, i.e. they all have a
> ns_capable(current_user_ns(), CAP_SYS_ADMIN)
> line. So if we specify
> setns(CLONE_NEWUSER | CLONE_NEW*)
> as an unprivileged user we aren't able to attach to any other namespace
> unless we check against the target credentials.
>
>> 
>> 
>> > (That's especially useful given
>> > that most users especially container runtimes will unshare all
>> > namespaces. Doing it this way we can not just have attach privileged
>> > users attach to their containers but also unprivileged users to their
>> > containers in one shot.)
>> 
>> That is a wonderful reason for doing things, and it is the reason
>> why I am asking about it because I think you have it backwards.
>> 
>> Especially in the context of some container runtimes like Kubernetes
>> that I have been told will do things like share a network namespace
>> across all containers in a POD.
>
> Kubernetes doesn't use user namespace at all so they need to run as root
> anyway so that's not a problem. And if we're talking about scenarios
> where some namespaces are shared and other's aren't then there'll be
> batch-attaching any, i.e. not all at once but some at once. So I don't
> think this is a good argument.
>
>> 
>> > A few other points about this. If one looks at clone(CLONE_NEW*) or
>> > unshare(CLONE_NEW*) then the ordering and permissions checking is the
>> > same way. All permissions checks are performed against the reduced
>> > permissions, i.e. if CLONE_NEWUSER is specified you check privilege
>> > against the reduced permissions too otherwise you wouldn't be able to
>> > spawn into a complete set of new namespaces as an unprivileged user.
>> 
>> That is a good catch and definitely a reason for looking at doing
>> things in this order.
>> 
>> For unshare and clone putting things in a user namespace means you can
>> create namespaces you could not create otherwise.
>> 
>> 
>> > This logic is also expressed in how setns() is already used in
>> > userspace. Any container runtime will attach to the user namespace first,
>> > so all subsequent calls to attach to other namespaces perform the checks
>> > against the reduced permissions. It also has to be that way because of
>> > fully unprivileged containers.
>> 
>> So I sat and looked.  For nsetner it winds up trying to enter
>> the namespaces in either order.
>> 
>>         /*
>>          * Now that we know which namespaces we want to enter, enter
>>          * them.  Do this in two passes, not entering the user
>>          * namespace on the first pass.  So if we're deprivileging the
>>          * container we'll enter the user namespace last and if we're
>>          * privileging it then we enter the user namespace first
>>          * (because the initial setns will fail).
>>          */
>>         for (pass = 0; pass < 2; pass ++) {
>>                 for (nsfile = namespace_files + 1 - pass; nsfile->nstype; nsfile++) {
>>                         if (nsfile->fd < 0)
>>                                 continue;
>>                         if (nsfile->nstype == CLONE_NEWPID && do_fork == -1)
>>                                 do_fork = 1;
>>                         if (setns(nsfile->fd, nsfile->nstype)) {
>>                                 if (pass != 0)
>>                                         err(EXIT_FAILURE,
>>                                             _("reassociate to namespace '%s' failed"),
>>                                             nsfile->name);
>>                                 else
>>                                         continue;
>>                         }
>> 
>>                         close(nsfile->fd);
>>                         nsfile->fd = -1;
>>                 }
>>         }
>> 
>> 
>> Looking a little close we have at least for entering the mntns the
>> following checks:
>> 
>> 	if (!ns_capable(mnt_ns->user_ns, CAP_SYS_ADMIN) ||
>> 	    !ns_capable(current_user_ns(), CAP_SYS_CHROOT) ||
>> 	    !ns_capable(current_user_ns(), CAP_SYS_ADMIN))
>> 		return -EPERM;
>> 
>> Which require CAP_SYS_CHROOT and CAP_SYS_ADMIN in the current user namespace.
>> 
>> So there is defintiely an issue there.
>> 
>> I suspect the clean approach is to simply require CAP_SYS_CHROOT in
>> the new user namespace, when we are setting several of them at once.
>
> See my example above. All install handlers check for
> ns_capable(current_user_ns(), CAP_SYS_ADMIN).
>
>
> static int ipcns_install(struct nsproxy *nsproxy, struct ns_common *new)
> {
> 	struct ipc_namespace *ns = to_ipc_ns(new);
> 	if (!ns_capable(ns->user_ns, CAP_SYS_ADMIN) ||
> 	    !ns_capable(current_user_ns(), CAP_SYS_ADMIN))
> 		return -EPERM;
>
>
> static int netns_install(struct nsproxy *nsproxy, struct ns_common *ns)
> {
> 	struct net *net = to_net_ns(ns);
>
> 	if (!ns_capable(net->user_ns, CAP_SYS_ADMIN) ||
> 	    !ns_capable(current_user_ns(), CAP_SYS_ADMIN))
> 		return -EPERM;
>
> static int mntns_install(struct nsproxy *nsproxy, struct ns_common *ns)
> {
> 	struct fs_struct *fs = current->fs;
> 	struct mnt_namespace *mnt_ns = to_mnt_ns(ns), *old_mnt_ns;
> 	struct path root;
> 	int err;
>
> 	if (!ns_capable(mnt_ns->user_ns, CAP_SYS_ADMIN) ||
> 	    !ns_capable(current_user_ns(), CAP_SYS_CHROOT) ||
> 	    !ns_capable(current_user_ns(), CAP_SYS_ADMIN))
> 		return -EPERM;
>
> static int cgroupns_install(struct nsproxy *nsproxy, struct ns_common *ns)
> {
> 	struct cgroup_namespace *cgroup_ns = to_cg_ns(ns);
>
> 	if (!ns_capable(current_user_ns(), CAP_SYS_ADMIN) ||
> 	    !ns_capable(cgroup_ns->user_ns, CAP_SYS_ADMIN))
> 		return -EPERM;
>
> static int utsns_install(struct nsproxy *nsproxy, struct ns_common *new)
> {
> 	struct uts_namespace *ns = to_uts_ns(new);
>
> 	if (!ns_capable(ns->user_ns, CAP_SYS_ADMIN) ||
> 	    !ns_capable(current_user_ns(), CAP_SYS_ADMIN))
> 		return -EPERM;
>
> static int pidns_install(struct nsproxy *nsproxy, struct ns_common *ns)
> {
> 	struct pid_namespace *active = task_active_pid_ns(current);
> 	struct pid_namespace *ancestor, *new = to_pid_ns(ns);
>
> 	if (!ns_capable(new->user_ns, CAP_SYS_ADMIN) ||
> 	    !ns_capable(current_user_ns(), CAP_SYS_ADMIN))
> 		return -EPERM;
>
>> 
>> > To put it another way, if we were to always perform the permission checks
>> > against the current permissions (i.e. no matter if CLONE_NEWUSER is
>> > specified or not) then we'd never be able to attach to a set of
>> > namespaces at once as an unprivileged user.
>> > We also really want to be able to express both semantics:
>> > 1. setns(flags & ~CLONE_NEWUSER) --> attach to all namespaces with my
>> >    current permission level
>> > 2. setns(flags | CLONE_NEWUSER) attach to all namespaces with the target
>> >    permission level
>> > It feels weird if both 1 and 2 would mean the exact same thing given
>> > that the user namespace has an owernship relation with all the other
>> > namespaces.
>> 
>> It feels weird to me to disallow anything that we have permissions for.
>> 
>> Can you dig up the actual install permissions checks and see if there is
>> anything other than the mount namespace that needs permissions in the
>> current user namespace?
>
> Yep did, all of them check ns_capable(current_user_ns(), CAP_SYS_ADMIN),
> see above please.
>
>> 
>> Please let's walk this through.  I think there should be a way to
>> carefully phrase the permission checks that we don't need
>> ns_capable_cred that will allow goofy cases like setns into Kuberneties
>> PODs that share network namespaces.
>
> Hm, Kubernetes doesn't use user namespace. I think I misunderstand your
> concern maybe. But see below for a suggestion.
>
>> 
>> I believe that will be a way to phrase the permission checks so that
>> with or without CLONE_NEWUSER they make sense, and give very similar
>> results.
>> 
>> Certainly attaching to a mount namespace is going to need either being
>> root or attaching to a user namespace at the same time.  Because
>> attaching to a mount namespace needs functionality that the user
>> namespace provides.
>
> So how about we add a new flag to setns()
> SETNS_NEWUSER_CRED that is only valid in
> conjunction with CLONE_NEWUSER and which allows callers to tell the
> kernel "assume the target credentials first". This way we can support
> both cases and users can specify what they want and we can clearly
> document it on the manpages.

Let's not get complicated.  Let's make this very simple.

Change "ns_capable(current_user_user_ns(), CAP_SYS_ADMIN)"
to     "ns_capable(nsset->cred->user_ns, CAP_SYS_ADMIN)".

We still use the current credentials, but we require the caller of setns
to have CAP_SYS_ADMIN in the user namespace you are going to wind up in.
That is exactly what userns_install does today.

That won't be any kind of security hole because we still require
     	"ns_capable(ns->user_ns, CAP_SYS_ADMIN)"
on all of the namespaces as well.

That way if you are sufficiently privileged you can still handle joining
namespaces that are not owned by the owner of the processes user
namespace.  So we can join weird processes.

Does that make sense?

Eric
