Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE02215B071
	for <lists+linux-api@lfdr.de>; Wed, 12 Feb 2020 20:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbgBLTFd (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 12 Feb 2020 14:05:33 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37536 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbgBLTFd (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 12 Feb 2020 14:05:33 -0500
Received: by mail-ot1-f67.google.com with SMTP id d3so3044961otp.4
        for <linux-api@vger.kernel.org>; Wed, 12 Feb 2020 11:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=foWRYWO78ULZBWItaixgqqE1dZLXg8h/ArW04ZpV+3U=;
        b=aV9YD0PIqGsFxeLHhOyB8Ic2JiX3zbqDjHrTiODkiO0DoQ18h/n+sV2sdQkaEqbuuP
         buYE1urSPPsSwhLczKzrO7hU4fml11RrGw+fG6rdYBVA4IwNLn18yZOQw0GncgXlkBaE
         +a2FGKnnD/Kq+QmgJe+kwhuP1xaIigldCfY/DvmtZnTiA2LJjpsXhiKGWDM2hKDQ0UW0
         weucAY2C1KlByL01wxA4iblHegp2xD2Zfu/wz/Q1ZpdE5+XjraGgBA2jDnLVTBjYxqHq
         MWJ8vk1fcDqo5XTfJr1HCSb8HJNlr+VV/T8mVGVjlpM+eK7SKWzwkJEqrXC0vwZ3nBPT
         KLMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=foWRYWO78ULZBWItaixgqqE1dZLXg8h/ArW04ZpV+3U=;
        b=caIrLWiGSNoMxvIwrGDvvk7QKAyZ1baSQnIh+XRRYS/LGVj2Ta8XipWqyrH7pXKrCJ
         xydim1kca+LlGbAT4xIOo6W89xklNGkkPor1FPZ5P/RhECC7aCrPLCoHCpTnlcxr5/yH
         fTyAeLA8Ga5fejoDHUaC+j4kv69yqrNMp/g3QtO2t00rNhcXifU2p2xWRv6/cQHFrJfi
         H4to+WLZzIvhNHTWILMr6OyHrwwzQx4IsB9M4ldnSydiYFl4aKe9dekEE1p1MaNAwmCs
         DVfoCJj0eGrn1F0vkjg2lR4oxAdPrPcGWoVLO7f3s33ByiM7oSP3YP51NykAUhRp9lxs
         KJUg==
X-Gm-Message-State: APjAAAV9ilXm81uCEXAp7x4bAUzEH5/CvAheTBHElap1Q0P/TzDgX9LO
        DNJkUpchKa3nFCKYKIlLS6NFHPfA9t641OOowJry0Q==
X-Google-Smtp-Source: APXvYqzgQj4eDYx0PaukBLn97gYpuIIZIXS0SSSHkr8pXEUse5dom9XQvCPHDdC+zo2PWeBUw9eJ1c3lLD2e0BuplHY=
X-Received: by 2002:a9d:7586:: with SMTP id s6mr10267881otk.342.1581534331557;
 Wed, 12 Feb 2020 11:05:31 -0800 (PST)
MIME-Version: 1.0
References: <20200211225547.235083-1-dancol@google.com> <20200211225547.235083-4-dancol@google.com>
 <ef13d728-9f1e-5e38-28a1-7ed7134840e4@tycho.nsa.gov> <CAKOZuesUVSYJ6EjHFL3QyiWKVmyhm1fLp5Bm_SHjB3_s1gn08A@mail.gmail.com>
 <ae8adb92-9c6e-2318-a3b9-903ead3848b5@tycho.nsa.gov> <69f4ccce-18b2-42c1-71ac-3fe9caf2dfb6@tycho.nsa.gov>
In-Reply-To: <69f4ccce-18b2-42c1-71ac-3fe9caf2dfb6@tycho.nsa.gov>
From:   Daniel Colascione <dancol@google.com>
Date:   Wed, 12 Feb 2020 11:04:54 -0800
Message-ID: <CAKOZuevoKDYGVSooWAhi7Jr6Ww-+NEd-sStaPcN5Q6g+NKKRPQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] Teach SELinux about a new userfaultfd class
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Tim Murray <timmurray@google.com>, Nosh Minwalla <nosh@google.com>,
        Nick Kralevich <nnk@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Feb 12, 2020 at 10:59 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> On 2/12/20 1:04 PM, Stephen Smalley wrote:
> > On 2/12/20 12:19 PM, Daniel Colascione wrote:
> >> Thanks for taking a look.
> >>
> >> On Wed, Feb 12, 2020 at 9:04 AM Stephen Smalley <sds@tycho.nsa.gov>
> >> wrote:
> >>>
> >>> On 2/11/20 5:55 PM, Daniel Colascione wrote:
> >>>> Use the secure anonymous inode LSM hook we just added to let SELinux
> >>>> policy place restrictions on userfaultfd use. The create operation
> >>>> applies to processes creating new instances of these file objects;
> >>>> transfer between processes is covered by restrictions on read, write,
> >>>> and ioctl access already checked inside selinux_file_receive.
> >>>>
> >>>> Signed-off-by: Daniel Colascione <dancol@google.com>
> >>>
> >>> (please add linux-fsdevel and viro to the cc for future versions of this
> >>> patch since it changes the VFS)
> >>>
> >>>> ---
> >>>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> >>>> index 1659b59fb5d7..e178f6f40e93 100644
> >>>> --- a/security/selinux/hooks.c
> >>>> +++ b/security/selinux/hooks.c
> >>>> @@ -2915,6 +2919,69 @@ static int selinux_inode_init_security(struct
> >>>> inode *inode, struct inode *dir,
> >>>> +
> >>>> +     /*
> >>>> +      * We shouldn't be creating secure anonymous inodes before LSM
> >>>> +      * initialization completes.
> >>>> +      */
> >>>> +     if (unlikely(!selinux_state.initialized))
> >>>> +             return -EBUSY;
> >>>
> >>> I don't think this is viable; any arbitrary actions are possible before
> >>> policy is loaded, and a Linux distro can be brought up fully with
> >>> SELinux enabled and no policy loaded.  You'll just need to have a
> >>> default behavior prior to initialization.
> >>
> >> We'd have to fail open then, I think, and return an S_PRIVATE inode
> >> (the regular anon inode).
> >
> > Not sure why.  You aren't doing anything in the hook that actually
> > relies on selinux_state.initialized being set (i.e. nothing requires a
> > policy).  The avc_has_perm() call will just succeed until a policy is
> > loaded.  So if these inodes are created prior to policy load, they will
> > get assigned the task SID (which would be the kernel SID prior to policy
> > load or first exec or write to /proc/self/attr/current afterward) and
> > UFFD class (in your current code), be permitted, and then once policy is
> > loaded any further access will get checked against the kernel SID.
> >
> >>>> +     /*
> >>>> +      * We only get here once per ephemeral inode.  The inode has
> >>>> +      * been initialized via inode_alloc_security but is otherwise
> >>>> +      * untouched, so check that the state is as
> >>>> +      * inode_alloc_security left it.
> >>>> +      */
> >>>> +     BUG_ON(isec->initialized != LABEL_INVALID);
> >>>> +     BUG_ON(isec->sclass != SECCLASS_FILE);
> >>>
> >>> I think the kernel discourages overuse of BUG_ON/BUG/...
> >>
> >> I'm not sure what counts as overuse.
> >
> > Me either (not my rule) but I'm pretty sure this counts or you'd see a
> > lot more of these kinds of BUG_ON() checks throughout.  Try to reserve
> > them for really critical cases.
> >
> >>>> +
> >>>> +#ifdef CONFIG_USERFAULTFD
> >>>> +     if (fops == &userfaultfd_fops)
> >>>> +             isec->sclass = SECCLASS_UFFD;
> >>>> +#endif
> >>>
> >>> Not sure we want or need to introduce a new security class for each user
> >>> of anonymous inodes since the permissions should be the same as for
> >>> file.
> >>
> >> The purpose of this change is to apply special policy to userfaultfd
> >> FDs in particular. Isn't having a UFFD security class the best way to
> >> go about that? (There's no path.) Am I missing something?
> >
> > It is probably the simplest approach; it just doesn't generalize to all
> > users of anonymous inodes. We can distinguish them in one of two ways:
> > use a different class like you did (requires a code change every time we
> > add a new one and yet another duplicate of the file class) or use a
> > different SID/context/type. The latter could be achieved by calling
> > security_transition_sid() with the provided name wrapped in a qstr and
> > specifying type_transition rules on the name.  Then policy could define
> > derived types for each domain, ala
> > type_transition init self:file "[userfaultfd]" init_userfaultfd;
> > type_transition untrusted_app self:file "[userfaultfd]"
> > untrusted_app_userfaultfd;
> > ...
> >
> >>> Also not sure we want to be testing fops for each such case.
> >>
> >> I was also thinking of just providing some kind of context string
> >> (maybe the name), which might be friendlier to modules, but the loose
> >> coupling kind of scares me, and for this particular application, since
> >> UFFD is always in the core and never in a module, checking the fops
> >> seems a bit more robust and doesn't hurt anything.
> >
> > Yes, not sure how the vfs folks feel about either coupling (the
> > name-based one or the fops-based one).  Neither seems great.
> >
> >>> We
> >>> were looking at possibly leveraging the name as a key and using
> >>> security_transition_sid() to generate a distinct SID/context/type for
> >>> the inode via type_transition rules in policy.  We have some WIP along
> >>> those lines.
> >>
> >> Where? Any chance it would be ready soon? I'd rather not hold up this
> >> work for a more general mechanism.
> >
> > Hopefully will have a patch available soon.  But not saying this
> > necessarily has to wait either.
> >
> >>>> +     /*
> >>>> +      * Always give secure anonymous inodes the sid of the
> >>>> +      * creating task.
> >>>> +      */
> >>>> +
> >>>> +     isec->sid = tsec->sid;
> >>>
> >>> This doesn't generalize for other users of anonymous inodes, e.g. the
> >>> /dev/kvm case where we'd rather inherit the SID and class from the
> >>> original /dev/kvm inode itself.
> >>
> >> I think someone mentioned on the first version of this patch that we
> >> could make it more flexible if the need arose. If we do want to do it
> >> now, we could have the anon_inode security hook accept a "parent" or
> >> "context" inode that modules could inspect for the purposes of forming
> >> the new inode's SID. Does that make sense to you?
> >
> > Yes, that's the approach in our current WIP, except we call it a
> > "related" inode since it isn't necessarily connected to the anon inode
> > in any vfs sense.
>
> The other key difference in our WIP approach is that we assumed that we
> couldn't mandate allocating a separate anon inode for each of these fds
> and we wanted to cover all anonymous inodes (not opt-in), so we are
> storing the SID/class pair as additional fields in the
> file_security_struct and have modified file_has_perm() and others to
> look there for anonymous inodes.

A separate inode seems like the simpler approach for now, because it
means that we have fewer places to check for security information ---
and it's not as if an inode is particularly expensive. We can always
switch later.
