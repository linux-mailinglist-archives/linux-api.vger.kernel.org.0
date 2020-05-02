Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D51491C2574
	for <lists+linux-api@lfdr.de>; Sat,  2 May 2020 14:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgEBMjP (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 2 May 2020 08:39:15 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:55786 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbgEBMjO (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 2 May 2020 08:39:14 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jUrQG-0003IM-R1; Sat, 02 May 2020 06:39:12 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jUrQF-0005eW-Tj; Sat, 02 May 2020 06:39:12 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Jann Horn <jannh@google.com>, linux-api@vger.kernel.org,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Michael Kerrisk <mtk.manpages@gmail.com>
References: <20200430165717.1001605-1-christian.brauner@ubuntu.com>
        <87y2qczvz9.fsf@x220.int.ebiederm.org>
        <20200501154251.j4iuz42tntnjcvaa@wittgenstein>
Date:   Sat, 02 May 2020 07:35:53 -0500
In-Reply-To: <20200501154251.j4iuz42tntnjcvaa@wittgenstein> (Christian
        Brauner's message of "Fri, 1 May 2020 17:42:51 +0200")
Message-ID: <874ksytsye.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jUrQF-0005eW-Tj;;;mid=<874ksytsye.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+MhK6vSjjYVw+ctWqOmUDjgX/rCXEUM5o=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,T_TooManySym_03 autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4997]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Christian Brauner <christian.brauner@ubuntu.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 522 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.8 (0.7%), b_tie_ro: 2.6 (0.5%), parse: 0.80
        (0.2%), extract_message_metadata: 11 (2.1%), get_uri_detail_list: 2.9
        (0.5%), tests_pri_-1000: 3.8 (0.7%), tests_pri_-950: 1.05 (0.2%),
        tests_pri_-900: 0.79 (0.2%), tests_pri_-90: 67 (12.9%), check_bayes:
        66 (12.7%), b_tokenize: 9 (1.7%), b_tok_get_all: 10 (2.0%),
        b_comp_prob: 2.5 (0.5%), b_tok_touch_all: 41 (7.9%), b_finish: 0.69
        (0.1%), tests_pri_0: 423 (81.1%), check_dkim_signature: 0.45 (0.1%),
        check_dkim_adsp: 2.1 (0.4%), poll_dns_idle: 0.92 (0.2%), tests_pri_10:
        1.68 (0.3%), tests_pri_500: 6 (1.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 1/4] capability: add ns_capable_cred()
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Christian Brauner <christian.brauner@ubuntu.com> writes:

> On Thu, Apr 30, 2020 at 01:09:30PM -0500, Eric W. Biederman wrote:
>> Christian Brauner <christian.brauner@ubuntu.com> writes:
>> 
>> > Add a simple capability helper which makes it possible to determine
>> > whether a set of creds is ns capable wrt to the passed in credentials.
>> > This is not something exciting it's just a more pleasant wrapper around
>> > security_capable() by allowing ns_capable_common() to ake a const struct
>> > cred argument. In ptrace_has_cap() for example, we're using
>> > security_capable() directly. ns_capable_cred() will be used in the next
>> > patch to check against the target credentials the caller is going to
>> > switch to.
>> 
>> Given that this is to suppot setns.  I don't understand the
>> justification for this.
>> 
>> Is it your intention to use the reduced permissions that you get
>> when you install a user namespace?
>
> Indeed.
>
>> 
>> Why do you want to use the reduced permissions when installing multiple
>> namespaces at once?
>
> The intention is to use the target credentials we are going to install
> when setns() hits the point of no return. The target permissions are
> either the permissions of the caller or the reduced permissions if
> CLONE_NEWUSER has been requested. This has multiple reasons.
>
> The most obvious reason imho is that all other namespaces have an owning
> user namespace. Attaching to any other namespace requires the attacher
> to be privileged over the owning user namespace of that namespace.
> Consequently, all our current install handlers for every namespace we
> have check whether we are privileged in the owning user namespace of
> that user namespace. So in order to attach to any of those namespaces -
> especially when attaching as an unprivileged user - requires that we are
> attached to the user namespace first.

No actually it doesn't.  As if you have privileges to attach to the user
namespace you have the privileges to attach to anything it owns.  Or you
should I think I am missing some subtle detail at the moment.


> (That's especially useful given
> that most users especially container runtimes will unshare all
> namespaces. Doing it this way we can not just have attach privileged
> users attach to their containers but also unprivileged users to their
> containers in one shot.)

That is a wonderful reason for doing things, and it is the reason
why I am asking about it because I think you have it backwards.

Especially in the context of some container runtimes like Kubernetes
that I have been told will do things like share a network namespace
across all containers in a POD.

> A few other points about this. If one looks at clone(CLONE_NEW*) or
> unshare(CLONE_NEW*) then the ordering and permissions checking is the
> same way. All permissions checks are performed against the reduced
> permissions, i.e. if CLONE_NEWUSER is specified you check privilege
> against the reduced permissions too otherwise you wouldn't be able to
> spawn into a complete set of new namespaces as an unprivileged user.

That is a good catch and definitely a reason for looking at doing
things in this order.

For unshare and clone putting things in a user namespace means you can
create namespaces you could not create otherwise.


> This logic is also expressed in how setns() is already used in
> userspace. Any container runtime will attach to the user namespace first,
> so all subsequent calls to attach to other namespaces perform the checks
> against the reduced permissions. It also has to be that way because of
> fully unprivileged containers.

So I sat and looked.  For nsetner it winds up trying to enter
the namespaces in either order.

        /*
         * Now that we know which namespaces we want to enter, enter
         * them.  Do this in two passes, not entering the user
         * namespace on the first pass.  So if we're deprivileging the
         * container we'll enter the user namespace last and if we're
         * privileging it then we enter the user namespace first
         * (because the initial setns will fail).
         */
        for (pass = 0; pass < 2; pass ++) {
                for (nsfile = namespace_files + 1 - pass; nsfile->nstype; nsfile++) {
                        if (nsfile->fd < 0)
                                continue;
                        if (nsfile->nstype == CLONE_NEWPID && do_fork == -1)
                                do_fork = 1;
                        if (setns(nsfile->fd, nsfile->nstype)) {
                                if (pass != 0)
                                        err(EXIT_FAILURE,
                                            _("reassociate to namespace '%s' failed"),
                                            nsfile->name);
                                else
                                        continue;
                        }

                        close(nsfile->fd);
                        nsfile->fd = -1;
                }
        }


Looking a little close we have at least for entering the mntns the
following checks:

	if (!ns_capable(mnt_ns->user_ns, CAP_SYS_ADMIN) ||
	    !ns_capable(current_user_ns(), CAP_SYS_CHROOT) ||
	    !ns_capable(current_user_ns(), CAP_SYS_ADMIN))
		return -EPERM;

Which require CAP_SYS_CHROOT and CAP_SYS_ADMIN in the current user namespace.

So there is defintiely an issue there.

I suspect the clean approach is to simply require CAP_SYS_CHROOT in
the new user namespace, when we are setting several of them at once.

> To put it another way, if we were to always perform the permission checks
> against the current permissions (i.e. no matter if CLONE_NEWUSER is
> specified or not) then we'd never be able to attach to a set of
> namespaces at once as an unprivileged user.
> We also really want to be able to express both semantics:
> 1. setns(flags & ~CLONE_NEWUSER) --> attach to all namespaces with my
>    current permission level
> 2. setns(flags | CLONE_NEWUSER) attach to all namespaces with the target
>    permission level
> It feels weird if both 1 and 2 would mean the exact same thing given
> that the user namespace has an owernship relation with all the other
> namespaces.

It feels weird to me to disallow anything that we have permissions for.

Can you dig up the actual install permissions checks and see if there is
anything other than the mount namespace that needs permissions in the
current user namespace?

Please let's walk this through.  I think there should be a way to
carefully phrase the permission checks that we don't need
ns_capable_cred that will allow goofy cases like setns into Kuberneties
PODs that share network namespaces.

I believe that will be a way to phrase the permission checks so that
with or without CLONE_NEWUSER they make sense, and give very similar
results.

Certainly attaching to a mount namespace is going to need either being
root or attaching to a user namespace at the same time.  Because
attaching to a mount namespace needs functionality that the user
namespace provides.

Eric
