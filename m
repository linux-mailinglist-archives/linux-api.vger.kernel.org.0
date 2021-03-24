Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 062E0346FF8
	for <lists+linux-api@lfdr.de>; Wed, 24 Mar 2021 04:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbhCXDL2 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 23 Mar 2021 23:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbhCXDK4 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 23 Mar 2021 23:10:56 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16EDC0613D9
        for <linux-api@vger.kernel.org>; Tue, 23 Mar 2021 20:10:55 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id s17so28345381ljc.5
        for <linux-api@vger.kernel.org>; Tue, 23 Mar 2021 20:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZegDJhsrs3t5DmLNRfuIr22Aaf3RCbcyU5Kj5Ptg79A=;
        b=M1aeEDxmk9ECf3516Cji4G52oSFsAn8KliAgARkCx5OFt/DI6XCdQtqOSm9+ierP53
         96dKx4KCJbD1lvEnlxaUGmiNHqSq7B9S+YnK8FMkPsxubMWmxCIKdd5hbiSOCmLVD8x2
         y6n2VRtZwCuBVid10EDPdpch8y7Qu9isZUjXElYw2NB9WvCorTXHb/TyI6ot3eE3NxDI
         7RsZdviWjL1D7m/r0hZMgfAIfoSy9HyDnzgjDhHI+4bgia3SIf9923vAMV2rMcGwAwJu
         +fnXWI39SCzeRrtCZiqNDUgvaQvB4cbJ5ZtxdmrQjAnfMEHQ9KUtf86yaWDN3j/WVdih
         Ii/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZegDJhsrs3t5DmLNRfuIr22Aaf3RCbcyU5Kj5Ptg79A=;
        b=QvSdpaV1xYYUo0I85P168zEFi+HjtuhlYSuZ/C2Ph9WpZ7EQy2PlILZy+p3LmpKWd8
         EvlKWq8juTztpouYNU0IFKpp3qqqP5OKVpePzAE3zgsYBdZRGfYFRA3teq+SLde56nl9
         BTcCuJT6M9TMYg4xDlJoA7PSF4cA2YOm1SVFk3qmCGloK0geAKofg+Lvz5/4e2fBRi/d
         X8MpRngTz6Em90AzvDmeXx+FN4in1fxtHezIHszo6Jj04gXXz9aETufEuasAOycG1viS
         G4dJcG2QABA7Uf1juT6mB3/ZbDSzO4B7XdEHmnD90aPiJIwXOuPUsfW4Pm7NP6ffhCAK
         Iz+A==
X-Gm-Message-State: AOAM531Wlx5KPYGR2ao2b5OIarGOWU13ssHCCq/acOYZuGyGzcGDC6Qs
        7VK+lzQwKbnHZuXsnAdk1tX9U5e2R4xHA4RXKGg3XQ==
X-Google-Smtp-Source: ABdhPJxSapwHRvBnLCwcoR2sXbNCQsSDCdMD6ytmf/icFhUU43QYK5yfde5P5ZIWyLr27rM90Izr4s50uVBB8ADYn3Q=
X-Received: by 2002:a2e:9310:: with SMTP id e16mr638054ljh.226.1616555454025;
 Tue, 23 Mar 2021 20:10:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210316204252.427806-1-mic@digikod.net> <20210316204252.427806-8-mic@digikod.net>
 <CAG48ez1arKO3uYzwng8fst-UHkcH6J7YzyHFN+vfXUT2=1HT+w@mail.gmail.com>
 <b41a021c-69f4-075f-e9a0-a4483b280df8@digikod.net> <CAG48ez1Vkd3KtYphDHLLbbkKY9T_ByhUcxwYAcWuDAyiA04A+w@mail.gmail.com>
 <7e494b74-8d5d-a109-6327-992d7d8fca87@digikod.net>
In-Reply-To: <7e494b74-8d5d-a109-6327-992d7d8fca87@digikod.net>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 24 Mar 2021 04:10:27 +0100
Message-ID: <CAG48ez0ex48pCgunrg+BpJ-LppZUVXhsmiEW_2d2mhbkDB793Q@mail.gmail.com>
Subject: Re: [PATCH v30 07/12] landlock: Support filesystem access-control
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        David Howells <dhowells@redhat.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Mar 23, 2021 at 8:22 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> =
wrote:
> On 23/03/2021 18:49, Jann Horn wrote:
> > On Tue, Mar 23, 2021 at 4:54 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.n=
et> wrote:
> >> On 23/03/2021 01:13, Jann Horn wrote:
> >>>  On Tue, Mar 16, 2021 at 9:43 PM Micka=C3=ABl Sala=C3=BCn <mic@digiko=
d.net> wrote:
> >>>> Using Landlock objects and ruleset, it is possible to tag inodes
> >>>> according to a process's domain.
> >>> [...]
> >>>> +static void release_inode(struct landlock_object *const object)
> >>>> +       __releases(object->lock)
> >>>> +{
> >>>> +       struct inode *const inode =3D object->underobj;
> >>>> +       struct super_block *sb;
> >>>> +
> >>>> +       if (!inode) {
> >>>> +               spin_unlock(&object->lock);
> >>>> +               return;
> >>>> +       }
> >>>> +
> >>>> +       /*
> >>>> +        * Protects against concurrent use by hook_sb_delete() of th=
e reference
> >>>> +        * to the underlying inode.
> >>>> +        */
> >>>> +       object->underobj =3D NULL;
> >>>> +       /*
> >>>> +        * Makes sure that if the filesystem is concurrently unmount=
ed,
> >>>> +        * hook_sb_delete() will wait for us to finish iput().
> >>>> +        */
> >>>> +       sb =3D inode->i_sb;
> >>>> +       atomic_long_inc(&landlock_superblock(sb)->inode_refs);
> >>>> +       spin_unlock(&object->lock);
> >>>> +       /*
> >>>> +        * Because object->underobj was not NULL, hook_sb_delete() a=
nd
> >>>> +        * get_inode_object() guarantee that it is safe to reset
> >>>> +        * landlock_inode(inode)->object while it is not NULL.  It i=
s therefore
> >>>> +        * not necessary to lock inode->i_lock.
> >>>> +        */
> >>>> +       rcu_assign_pointer(landlock_inode(inode)->object, NULL);
> >>>> +       /*
> >>>> +        * Now, new rules can safely be tied to @inode with get_inod=
e_object().
> >>>> +        */
> >>>> +
> >>>> +       iput(inode);
> >>>> +       if (atomic_long_dec_and_test(&landlock_superblock(sb)->inode=
_refs))
> >>>> +               wake_up_var(&landlock_superblock(sb)->inode_refs);
> >>>> +}
> >>> [...]
> >>>> +static struct landlock_object *get_inode_object(struct inode *const=
 inode)
> >>>> +{
> >>>> +       struct landlock_object *object, *new_object;
> >>>> +       struct landlock_inode_security *inode_sec =3D landlock_inode=
(inode);
> >>>> +
> >>>> +       rcu_read_lock();
> >>>> +retry:
> >>>> +       object =3D rcu_dereference(inode_sec->object);
> >>>> +       if (object) {
> >>>> +               if (likely(refcount_inc_not_zero(&object->usage))) {
> >>>> +                       rcu_read_unlock();
> >>>> +                       return object;
> >>>> +               }
> >>>> +               /*
> >>>> +                * We are racing with release_inode(), the object is=
 going
> >>>> +                * away.  Wait for release_inode(), then retry.
> >>>> +                */
> >>>> +               spin_lock(&object->lock);
> >>>> +               spin_unlock(&object->lock);
> >>>> +               goto retry;
> >>>> +       }
> >>>> +       rcu_read_unlock();
> >>>> +
> >>>> +       /*
> >>>> +        * If there is no object tied to @inode, then create a new o=
ne (without
> >>>> +        * holding any locks).
> >>>> +        */
> >>>> +       new_object =3D landlock_create_object(&landlock_fs_underops,=
 inode);
> >>>> +       if (IS_ERR(new_object))
> >>>> +               return new_object;
> >>>> +
> >>>> +       /* Protects against concurrent get_inode_object() calls. */
> >>>> +       spin_lock(&inode->i_lock);
> >>>> +       object =3D rcu_dereference_protected(inode_sec->object,
> >>>> +                       lockdep_is_held(&inode->i_lock));
> >>>
> >>> rcu_dereference_protected() requires that inode_sec->object is not
> >>> concurrently changed, but I think another thread could call
> >>> get_inode_object() while we're in landlock_create_object(), and then
> >>> we could race with the NULL write in release_inode() here? (It
> >>> wouldn't actually be a UAF though because we're not actually accessin=
g
> >>> `object` here.) Or am I missing a lock that prevents this?
> >>>
> >>> In v28 this wasn't an issue because release_inode() was holding
> >>> inode->i_lock (and object->lock) during the NULL store; but in v29 an=
d
> >>> this version the NULL store in release_inode() moved out of the locke=
d
> >>> region. I think you could just move the NULL store in release_inode()
> >>> back up (and maybe add a comment explaining the locking rules for
> >>> landlock_inode(...)->object)?
> >>>
> >>> (Or alternatively you could use rcu_dereference_raw() with a comment
> >>> explaining that the read pointer is only used to check for NULL-ness,
> >>> and that it is guaranteed that the pointer can't change if it is NULL
> >>> and we're holding the lock. But that'd be needlessly complicated, I
> >>> think.)
> >>
> >> To reach rcu_assign_pointer(landlock_inode(inode)->object, NULL) in
> >> release_inode() or in hook_sb_delete(), the
> >> landlock_inode(inode)->object need to be non-NULL,
> >
> > Yes.
> >
> >> which implies that a
> >> call to get_inode_object(inode) either "retry" (because release_inode =
is
> >> only called by landlock_put_object, which set object->usage to 0) unti=
l
> >> it creates a new object, or reuses the existing referenced object (and
> >> increments object->usage).
> >
> > But it can be that landlock_inode(inode)->object only becomes non-NULL
> > after get_inode_object() has checked
> > rcu_dereference(inode_sec->object).
> >
> >> The worse case would be if
> >> get_inode_object(inode) is called just before the
> >> rcu_assign_pointer(landlock_inode(inode)->object, NULL) from
> >> hook_sb_delete(), which would result in an object with a NULL underobj=
,
> >> which is the expected behavior (and checked by release_inode).
> >
> > The scenario I'm talking about doesn't involve hook_sb_delete().
> >
> >> The line rcu_assign_pointer(inode_sec->object, new_object) from
> >> get_inode_object() can only be reached if the underlying inode doesn't
> >> reference an object,
> >
> > Yes.
> >
> >> in which case hook_sb_delete() will not reach the
> >> rcu_assign_pointer(landlock_inode(inode)->object, NULL) line for this
> >> same inode.
> >>
> >> This works because get_inode_object(inode) is mutually exclusive to
> >> itself with the same inode (i.e. an inode can only point to an object
> >> that references this same inode).
> >
> > To clarify: You can concurrently call get_inode_object() multiple
> > times on the same inode, right? There are no locks held on entry to
> > that function.
> >
> >> I tried to explain this with the comment "Protects against concurrent
> >> get_inode_object() calls" in get_inode_object(), and the comments just
> >> before both rcu_assign_pointer(landlock_inode(inode)->object, NULL).
> >
> > The scenario I'm talking about is:
> >
> > Initially the inode does not have an associated landlock_object. There
> > are two threads A and B. Thread A is going to execute
> > get_inode_object(). Thread B is going to execute get_inode_object()
> > followed immediately by landlock_put_object().
> >
> > thread A: enters get_inode_object()
> > thread A: rcu_dereference(inode_sec->object) returns NULL
> > thread A: enters landlock_create_object()
> > thread B: enters get_inode_object()
> > thread B: rcu_dereference(inode_sec->object) returns NULL
> > thread B: calls landlock_create_object()
> > thread B: sets inode_sec->object while holding inode->i_lock
> > thread B: leaves get_inode_object()
> > thread B: enters landlock_put_object()
> > thread B: object->usage drops to 0, object->lock is taken
> > thread B: calls release_inode()
> > thread B: drops object->lock
> > thread A: returns from landlock_create_object()
> > thread A: takes inode->i_lock
> >
> > At this point, thread B will run:
> >
> >     rcu_assign_pointer(landlock_inode(inode)->object, NULL);
> >
> > while thread A runs:
> >
> >     rcu_dereference_protected(inode_sec->object,
> >         lockdep_is_held(&inode->i_lock));
> >
> > meaning there is a (theoretical) data race, since
> > rcu_dereference_protected() doesn't use READ_ONCE().
>
> Hum, I see, that is what I was missing. And that explain why there is
> (in practice) no impact on winning the race.
>
> I would prefer to use rcu_access_pointer() instead of
> rcu_dereference_protected() to avoid pitfall, and it reflects what I was
> expecting:
>
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -117,9 +117,7 @@ static struct landlock_object
> *get_inode_object(struct inode *const inode)
>
>         /* Protects against concurrent get_inode_object() calls. */
>         spin_lock(&inode->i_lock);
> -       object =3D rcu_dereference_protected(inode_sec->object,
> -                       lockdep_is_held(&inode->i_lock));
> -       if (unlikely(object)) {
> +       if (unlikely(rcu_access_pointer(inode_sec->object))) {
>                 /* Someone else just created the object, bail out and
> retry. */
>                 spin_unlock(&inode->i_lock);
>                 kfree(new_object);

Ah, yeah, that should work. I had forgotten about rcu_access_pointer().

> But I'm not sure about your proposition to move the NULL store in
> release_inode() back up. Do you mean to add back the inode lock in
> release_inode() like this?
>
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -59,16 +59,12 @@ static void release_inode(struct landlock_object
> *const object)
>          * Makes sure that if the filesystem is concurrently unmounted,
>          * hook_sb_delete() will wait for us to finish iput().
>          */
> +       spin_lock(&inode->i_lock);
>         sb =3D inode->i_sb;
>         atomic_long_inc(&landlock_superblock(sb)->inode_refs);
>         spin_unlock(&object->lock);
> -       /*
> -        * Because object->underobj was not NULL, hook_sb_delete() and
> -        * get_inode_object() guarantee that it is safe to reset
> -        * landlock_inode(inode)->object while it is not NULL.  It is the=
refore
> -        * not necessary to lock inode->i_lock.
> -        */
>         rcu_assign_pointer(landlock_inode(inode)->object, NULL);
> +       spin_unlock(&inode->i_lock);
>         /*
>          * Now, new rules can safely be tied to @inode with get_inode_obj=
ect().
>          */
>
>
> I would prefer to avoid nested locks if it is not necessary though.

Hm, yeah, you have a point there.

Doing it locklessly does make the locking rules a little complicated
though, and you'll have to update the comment inside struct
landlock_inode_security. At the moment, it says:

* @object: Weak pointer to an allocated object.  All writes (i.e.
* creating a new object or removing one) are protected by the
* underlying inode->i_lock.  Disassociating @object from the inode is
* additionally protected by @object->lock, from the time @object's
* usage refcount drops to zero to the time this pointer is nulled out.

which isn't true anymore.
