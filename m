Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D569B6E8C7F
	for <lists+linux-api@lfdr.de>; Thu, 20 Apr 2023 10:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234202AbjDTIPi (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 Apr 2023 04:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234184AbjDTIPg (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 20 Apr 2023 04:15:36 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267722717;
        Thu, 20 Apr 2023 01:15:35 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id az21so1587173uab.12;
        Thu, 20 Apr 2023 01:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681978534; x=1684570534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xx9rKKcYAarcaRH7Qi37CBJaRyETY6+irrlNfR3daf8=;
        b=cT4xuNB8DXKPN9BaZ+qgTB3ZRT3e7I+uODTVqrbQZYoWSl2AEZkRmvnR/200J3rLOe
         leWUwq/eU7hIGXyECk5kE5DxpRJzPqr5jDt2e594ZtaUQCPyrLs6LoPSfAy34DrkNdwu
         XJJtMKeXCqir2JW7erOQM6H5C6tMWJdwqACmO3u8zDa+jzJkijttEaPLEm6cgQMi8/zJ
         2LY0YPK3j64YMWz3Qy1zcDVByZMKxKROJ2oABDwNBctKrtRN/d0dWQ6XFQOaXflfnoq+
         2F9XAFyf2WXrHhzzt7W+x1MrgwFfh9Me1Wdib+Q2hgPzh7DEXaCnARatEsGQemPYXmpc
         Wl5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681978534; x=1684570534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xx9rKKcYAarcaRH7Qi37CBJaRyETY6+irrlNfR3daf8=;
        b=hNTrVfXBOWJLWxqPX6GXhXhX0vYwDRGyIojwnNMmb6LoB5iaHL81EQa+U4B2cR/nN0
         SIOj4iY5vIDdsBbDbzq0mffrgCHA5ZVUuSK2TrIfabsMc55G5WNPevrmTyeyoiJ8vQsy
         VMtpfxUo0t0pJjECxwlrP4/TRIbqQEfBIA4hGgUbW/cf/mUgFj+i+DYvr6t16LrVgd40
         AuuoDqv1/XrVpM8/FL47dAKaYvH5OWtmhDUrxF8UDsslcF7n6IBWVxQ6PJz8u4yYwVFS
         +X1SRNZyOimR8ngbvS92BTMeo0dayR4qOCMgONF82b3GyY75CcjDBgpetSbc1VTI/elg
         4xnQ==
X-Gm-Message-State: AAQBX9dcLOg3A0tVg9SS6IQllDA07QwPW7Gy2K9vdQSuFZHjsTkfzomb
        tWN5SMBZ+d8XNWGt1fvMYrYukvR+/7nkpAW48b8=
X-Google-Smtp-Source: AKy350ZTib4iEjkeLWTfulq36D893FnoR7lD73rVp8T+bEBmRExPuW5BVeGwDnDIhsAgIFQVcec2QXEyD550b25LuEw=
X-Received: by 2002:a1f:940e:0:b0:406:6b94:c4fe with SMTP id
 w14-20020a1f940e000000b004066b94c4femr571842vkd.0.1681978534088; Thu, 20 Apr
 2023 01:15:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230414182903.1852019-1-amir73il@gmail.com> <20230418-diesmal-heimlaufen-ba2f2d1e1938@brauner>
 <CAOQ4uxj5UwDhV7XxWZ-Os+fzM=_N1DDWHpjmt6UnHr96EDriMw@mail.gmail.com>
 <20230418-absegnen-sputen-11212a0615c7@brauner> <CAOQ4uxgM2x93UKcJ5D5tfoTt8s0ChTrEheTGqTcndGoyGwS=7w@mail.gmail.com>
 <20230419-besungen-filzen-adad4a1f3247@brauner> <CAOQ4uxgPsxtNHgvETTUyYrguPmOBOK=jzRHgfivSDbbNPnzL2w@mail.gmail.com>
 <20230420-funkverkehr-adler-7f6794bea737@brauner>
In-Reply-To: <20230420-funkverkehr-adler-7f6794bea737@brauner>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 20 Apr 2023 11:15:22 +0300
Message-ID: <CAOQ4uxiqV6=iuXZzMMgw4zZZfFSF-MYDxn49m0o59Fv9WFyw2Q@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/2] Monitoring unmounted fs with fanotify
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Apr 20, 2023 at 10:46=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> On Thu, Apr 20, 2023 at 09:12:52AM +0300, Amir Goldstein wrote:
> > On Wed, Apr 19, 2023 at 8:19=E2=80=AFPM Christian Brauner <brauner@kern=
el.org> wrote:
> > >
> > > On Tue, Apr 18, 2023 at 06:20:22PM +0300, Amir Goldstein wrote:
> > > > On Tue, Apr 18, 2023 at 5:12=E2=80=AFPM Christian Brauner <brauner@=
kernel.org> wrote:
> > > > >
> > > > > On Tue, Apr 18, 2023 at 04:56:40PM +0300, Amir Goldstein wrote:
> > > > > > On Tue, Apr 18, 2023 at 4:33=E2=80=AFPM Christian Brauner <brau=
ner@kernel.org> wrote:
> >
> > [...]
> >
> > > > > > Just thought of another reason:
> > > > > >  c) FAN_UNMOUNT does not need to require FAN_REPORT_FID
> > > > > >      so it does not depend on filesystem having a valid f_fsid =
nor
> > > > > >      exports_ops. In case of "pseudo" fs, FAN_UNMOUNT can repor=
t
> > > > > >      only MNTID record (I will amend the patch with this minor =
change).
> > > > >
> > > > > I see some pseudo fses generate f_fsid, e.g., tmpfs in mm/shmem.c
> > > >
> > > > tmpfs is not "pseudo" in my eyes, because it implements a great dea=
l of the
> > > > vfs interfaces, including export_ops.
> > >
> > > The term "pseudo" is somewhat well-defined though, no? It really just
> > > means that there's no backing device associated with it. So for examp=
le,
> > > anything that uses get_tree_nodev() including tmpfs. If erofs is
> > > compiled with fscache support it's even a pseudo fs (TIL).
> > >
> >
> > Ok, "pseudo fs" is an ambiguous term.
> >
> > For the sake of this discussion, let's refer to fs that use get_tree_no=
dev()
> > "non-disk fs".
> >
> > But as far as fsnotify is concerned, tmpfs is equivalent to xfs, becaus=
e
> > all of the changes are made by users via vfs.
> >
> > Let's call fs where changes can occur not via vfs "remote fs", those
> > include the network fs and some "internal fs" like the kernfs class of =
fs
> > and the "simple fs" class of fs (i.e. simple_fill_super).
> >
> > With all the remote fs, the behavior of fsnotify is (and has always bee=
n)
> > undefined, that is, you can use inotify to subscribe for events and you
> > never know what you will get when changes are not made via vfs.
> >
> > Some people (hypothetical) may expect to watch nsfs for dying ns
> > and may be disappointed to find out that they do not get the desired
> > IN_DELETE event.
> >
> > We have had lengthy discussions about remote fs change notifications
> > with no clear decisions of the best API for them:
> > https://lore.kernel.org/linux-fsdevel/20211025204634.2517-1-iangelak@re=
dhat.com/
> >
> > > >
> > > > and also I fixed its f_fsid recently:
> > > > 59cda49ecf6c shmem: allow reporting fanotify events with file handl=
es on tmpfs
> > >
> > > Well thank you for that this has been very useful in userspace alread=
y
> > > I've been told.
> > >
> > > >
> > > > > At the risk of putting my foot in my mouth, what's stopping us fr=
om
> > > > > making them all support f_fsid?
> > > >
> > > > Nothing much. Jan had the same opinion [1].
> > >
> > > I think that's what we should try to do without having thought too mu=
ch
> > > about potential edge-cases.
> > >
> > > >
> > > > We could do either:
> > > > 1. use uuid_to_fsid() in vfs_statfs() if fs has set s_uuid and not =
set f_fsid
> > > > 2. use s_dev as f_fsid in vfs_statfs() if fs did not set f_fsid nor=
 s_uuid
> > > > 3. randomize s_uuid for simple fs (like tmpfs)
> > > > 4. any combination of the above and more
> > > >
> > > > Note that we will also need to decide what to do with
> > > > name_to_handle_at() for those pseudo fs.
> > >
> > > Doing it on the fly during vfs_statfs() feels a bit messy and could
> > > cause bugs. One should never underestimate the possibility that there=
's
> > > some fs that somehow would get into trouble because of odd behavior.
> > >
> > > So switching each fs over to generate a s_uuid seems the prudent thin=
g
> > > to do. Doing it the hard way also forces us to make sure that each
> > > filesystem can deal with this.
> > >
> > > It seems that for pseudo fses we can just allocate a new s_uuid for e=
ach
> > > instance. So each tmpfs instance - like your patch did - would just g=
et
> > > a new s_uuid.
> > >
> > > For kernel internal filesystems - mostly those that use init_pseudo -
> > > the s_uuid would remain stable until the next reboot when it is
> > > regenerated.
> > >
> >
> > I am fine with opt-in for every fs as long as we do not duplicate
> > boilerplate code.
> > An FS_ flag could be a simple way to opt-in for this generic behavior.
> >
> > > Looking around just a little there's some block-backed fses like fat
> > > that have an f_fsid but no s_uuid. So if we give those s_uuid then it=
'll
> > > mean that the f_fsid isn't generated based on the s_uuid. That should=
 be
> > > ok though and shouldn't matter to userspace.
> > >
> > > Afterwards we could probably lift the ext4 and xfs specific ioctls to
> > > retrieve the s_uuid into a generic ioctl to allow userspace to get th=
e
> > > s_uuid.
> > >
> > > That's my thinking without having crawled to all possible corner
> > > cases... Also needs documenting that s_uuid is not optional anymore a=
nd
> > > explain the difference between pseudo and device-backed fses. I hope
> > > that's not completely naive...
> > >
> >
> > I don't think that the dichotomy of device-backed vs. pseudo is enough
> > to describe the situation.
> >
> > I think what needs to be better documented and annotated is what type
> > of fsnotify services can be expected to work on a given fs.
>
> You're looking at this solely from the angle of fanotify. In my earier
> message I was looking at this as something that is generally useful.
> Fanotify uses the s_uuid and f_fsid but they have value independent of
> this.
>

Right. Overlayfs to name another internal user of s_uuid.
and it would be useful for exportfs.
Currently, userspace needs to workaround this by assigning fsid=3D
manually in /etc/exports or by querying the uuid of the blockdev
within libblkid.

> >
> > Jan has already introduced FS_DISALLOW_NOTIFY_PERM to opt-out
> > of permission events (for procfs).
>
> That sounds like a decent solution.
>
> >
> > Perhaps this could be generalized to s_type->fs_notify_supported_events
> > or s_type->fs_notify_supported_features.
> >
> > For example, if an fs opts-in to FAN_REPORT_FID, then it gets an auto
> > allocated s_uuid and f_fsid if it did not fill them in fill_super and i=
n statfs
>
> This appears a layering violation to me. The s_uuid should be allocated
> when the superblock is created just like tmpfs does it and not
> retroactively/lazily when fanotify on the filesystem is reported.

That's not what I meant.

Extending the NFS file handles to fs object identification in
a generic concept - it does not serve only fanotify.
For fanotify, I deliberately chose to report object information that is
available to userspace via other UAPIs.

What I meant was:
* filesystem can opt-in for exporting file id's to userspace, either with
  .fs_flags =3D FS_EXPORT_FID
  or with a new export_op method as Jan suggested, e.g.:
  export_op.encode_fid =3D generic_encode_fid64;

With this opt-in, filesystem objects are more uniquely identified, so:
* vfs enforces non empty s_uuid and non empty f_fsid
* name_to_handle_at(....,AT_HANDLE_FID) returns a file handle for
  ID purpose that may (or may not) be useful in open_by_handle_at()
  even for fs that do not support NFS export
* fanotify allows FAN_ERPORT_FID even with the absence of
  NFS export support

I think we are all thinking more or less about the same solution.
This is the time for me to stop writing emails and start writing patches
so we have a better ground for discussion on the details...

Thanks,
Amir.
