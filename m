Return-Path: <linux-api+bounces-5082-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F26BCD940
	for <lists+linux-api@lfdr.de>; Fri, 10 Oct 2025 16:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8C2CC4E9D9B
	for <lists+linux-api@lfdr.de>; Fri, 10 Oct 2025 14:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F9F2F6168;
	Fri, 10 Oct 2025 14:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lo8ohFfD"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C281799F
	for <linux-api@vger.kernel.org>; Fri, 10 Oct 2025 14:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760107347; cv=none; b=gSlziVrJ2aKeZC1yxDBTrGUlB3uGWkDsf2NOaLEA+l51Du01a/FZaps35QkQzLye9szzxdLbgQlgv1N8+fJAbeTI8DzupxcnWmw+NDSwnBxVzCcQvCmE/w44sjNywhvGjlgzsWhOJcPoSXj8pvOeCYrvdiyiD5RHUQZx5kEU1kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760107347; c=relaxed/simple;
	bh=0s4IbHxpsZYsEeLq2mqAk8GBRa1ktEVkQshD92Q/jiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uE7SNrFfEKbHzhiErKFKilYq51RTHHUbYsmGfucNSJH7LWbyUpFknptPQNe7vyEyh0r8BKkKQCbP3LHDj/zKbK2oAZZnaNQr6Z4jFFh2elNZrmpyoiWP47Lfl7QivhbZwtkfsgxwYiXCp0rb1Mhr+skOZMYQGnbn+0k3q7eqk2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lo8ohFfD; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3324fdfd54cso2408871a91.0
        for <linux-api@vger.kernel.org>; Fri, 10 Oct 2025 07:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760107344; x=1760712144; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/1lnHPEdEWZo+CQq4FmAQbXLK0sMDF/The3o/4XWkFk=;
        b=lo8ohFfD575FURv7M+Vn0+AkhXFf5gxUF9KxmmnwiYPkzfU77uVZ2OU/CK6vsst2FM
         ozhz4qhuJDx65oa/8tfRwLW+mGQPiGziz5ar9A0fOmCTnrMF7TpstG+YntglQ3aFbRyY
         bjkGK1Rrz6KALC0HPJ4E3TUwtVDkzci0Dzu9kDYguMCZnTGPWLvDVSmoyc5nTfmZPV1j
         XGVGnLbq1+x5xmunvaTeVxNABiooZ+O+MSjN2SycOeOwJ9BDbPjxblGobU3lnwCwY6+8
         nLQrQVaUM5FRj5rKRsWbWhGlB7Hi0pcyagccoNQsP1EcPhz2PVUtgeeuUIWimkyhUzan
         yegQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760107344; x=1760712144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/1lnHPEdEWZo+CQq4FmAQbXLK0sMDF/The3o/4XWkFk=;
        b=FBb8juWfEDdiTb8IRlFTVvfjCbTE0RQrvKZogC9Cdltc5AgRHkIFIViuvcnNpcweOL
         9PnjO1y0w85YRSg8punzbrfc6/NbCTOpiamiAu6x4NCj6LTT/VtaCAYW3/0+VcNlZrvI
         a2j4/TD1boqz/h2rt0+nRWD5+igz2nP1bMAEGEl6wj24mL6aqQXnWsiDBYNOYdq6P4+1
         1EgCIkTQ+I75YMqMzYl7tCKJeHO8TzWwJD556B3Or2h0cbiQmRU1qNhs7UgY4ThXJ39O
         VWJnlBqv9r0gKXa8EPxF+xKW60xdB+QKntiRpqfSU8bl+1KKPUbiAGEqyIIMN4+PSEv8
         knrw==
X-Forwarded-Encrypted: i=1; AJvYcCVDVVPHsshoABE7izPbsxYibMVV3LyhCUqP9m0Fg2wZ5UMGYdaBPCMXaTpGnCc5+iNayiWtLeT4uXE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5H253bbYFzOu9LXo9Q7nxIF79sTwSWgk38sEzinMHHvDGi0Na
	0jKIhm967X+88D9J/lRSj4rGRaIuOrYSidqSv61/qhFjrFNhkQ0eWnq0/vVpQZqLA/dwQQlZyl8
	v9YHbJZUh3Lv9zX3gR0vcAC89m+ZcGnQ=
X-Gm-Gg: ASbGncsDipBC6Flc30sfdq+b6Rm1wSP73xYDQtI1J3pLNuaJIVdSgy8eUKB1ZL8ZFES
	dCpP2nrkGSSCL9Gu1p/MUAYX8Rx/nhmc3fxEFcR2P95cBe/JRtoywwyavS+OQ3Z3MIpDrG1jfqD
	VKXxuDqYojCnw88cNbKtkwl1pf2HP0883PD+LHjwlcZaJRjocJTcZAilh/GOBBk27BzLNSvMmTN
	lpE9J4VBoRBTXOka6NOzd17Lo/W8sA9pRuO
X-Google-Smtp-Source: AGHT+IFsXItlp5QPUTqsr8CSOUNYNVTKUJnhco/kz6hzhqLLhxhwLkRrKj2BGYxqo3gsOdsVV3rvBkk7udICunbK7f8=
X-Received: by 2002:a17:90b:1641:b0:330:4a1d:223c with SMTP id
 98e67ed59e1d1-33b5116a6a6mr16709971a91.15.1760107343707; Fri, 10 Oct 2025
 07:42:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010132610.12001-1-maxime.belair@canonical.com>
 <20251010132610.12001-5-maxime.belair@canonical.com> <CAEjxPJ6Xcwsic_zyLTPdHHaY9r7-ZTySzyELQ76aVZCFbh8FMQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ6Xcwsic_zyLTPdHHaY9r7-ZTySzyELQ76aVZCFbh8FMQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 10 Oct 2025 10:42:12 -0400
X-Gm-Features: AS18NWDccWyH7c6wXJg45erB-Ave82Isew0ZMf5dyNnwkmOaYknftSjGFvm9TU4
Message-ID: <CAEjxPJ5hbGrDPv3bRb1hhBw3+w=wOR3vxW5n9FnNLL8Uv-f0YQ@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] SELinux: add support for lsm_config_system_policy
To: =?UTF-8?Q?Maxime_B=C3=A9lair?= <maxime.belair@canonical.com>
Cc: linux-security-module@vger.kernel.org, john.johansen@canonical.com, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, mic@digikod.net, 
	kees@kernel.org, casey@schaufler-ca.com, takedakn@nttdata.co.jp, 
	penguin-kernel@i-love.sakura.ne.jp, song@kernel.org, rdunlap@infradead.org, 
	linux-api@vger.kernel.org, apparmor@lists.ubuntu.com, 
	linux-kernel@vger.kernel.org, SElinux list <selinux@vger.kernel.org>, 
	Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 9:58=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Oct 10, 2025 at 9:27=E2=80=AFAM Maxime B=C3=A9lair
> <maxime.belair@canonical.com> wrote:
> >
> > Enable users to manage SELinux policies through the new hook
> > lsm_config_system_policy. This feature is restricted to CAP_MAC_ADMIN.
>
> (added selinux mailing list and Fedora/Red Hat SELinux kernel maintainer =
to cc)
>
> A couple of observations:
> 1. We do not currently require CAP_MAC_ADMIN for loading SELinux
> policy, since it was only added later for Smack and SELinux implements
> its own permission checks. When loading policy via selinuxfs, one
> requires uid-0 or CAP_DAC_OVERRIDE to write to /sys/fs/selinux/load
> plus the corresponding SELinux permissions, but this is just an
> artifact of the filesystem-based interface. I'm not opposed to using
> CAP_MAC_ADMIN for loading policy via the new system call but wanted to
> note it as a difference.
>
> 2. The SELinux namespaces support [1], [2] is based on instantiating a
> separate selinuxfs instance for each namespace; you load a policy for
> a namespace by mounting a new selinuxfs instance after unsharing your
> SELinux namespace and then write to its /sys/fs/selinux/load
> interface, only affecting policy for the new namespace. Your interface
> doesn't appear to support such an approach and IIUC will currently
> always load the init SELinux namespace's policy rather than the
> current process' SELinux namespace.

Actually, on second thought, checking CAP_MAC_ADMIN via capable() will
require the process to have that capability in the global/init
namespace, which IIUC would prevent systemd running in a non-init user
namespace from loading the SELinux policy at all. That's problematic
for a different reason since it would prevent us from using this
interface for loading the namespace policy using this system call.
>
> [1] https://github.com/stephensmalley/selinuxns
> [2] https://lore.kernel.org/selinux/20250814132637.1659-1-stephen.smalley=
.work@gmail.com/
>
> >
> > Signed-off-by: Maxime B=C3=A9lair <maxime.belair@canonical.com>
> > ---
> >  security/selinux/hooks.c            | 27 +++++++++++++++++++++++++++
> >  security/selinux/include/security.h |  7 +++++++
> >  security/selinux/selinuxfs.c        | 16 ++++++++++++----
> >  3 files changed, 46 insertions(+), 4 deletions(-)
> >
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index e7a7dcab81db..3d14d4e47937 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -7196,6 +7196,31 @@ static int selinux_uring_allowed(void)
> >  }
> >  #endif /* CONFIG_IO_URING */
> >
> > +/**
> > + * selinux_lsm_config_system_policy - Manage a LSM policy
> > + * @op: operation to perform. Currently, only LSM_POLICY_LOAD is suppo=
rted
> > + * @buf: User-supplied buffer
> > + * @size: size of @buf
> > + * @flags: reserved for future use; must be zero
> > + *
> > + * Returns: number of written rules on success, negative value on erro=
r
> > + */
> > +static int selinux_lsm_config_system_policy(u32 op, void __user *buf,
> > +                                           size_t size, u32 flags)
> > +{
> > +       loff_t pos =3D 0;
> > +
> > +       if (op !=3D LSM_POLICY_LOAD || flags)
> > +               return -EOPNOTSUPP;
> > +
> > +       if (!selinux_null.dentry || !selinux_null.dentry->d_sb ||
> > +           !selinux_null.dentry->d_sb->s_fs_info)
> > +               return -ENODEV;
> > +
> > +       return __sel_write_load(selinux_null.dentry->d_sb->s_fs_info, b=
uf, size,
> > +                               &pos);
> > +}
> > +
> >  static const struct lsm_id selinux_lsmid =3D {
> >         .name =3D "selinux",
> >         .id =3D LSM_ID_SELINUX,
> > @@ -7499,6 +7524,8 @@ static struct security_hook_list selinux_hooks[] =
__ro_after_init =3D {
> >  #ifdef CONFIG_PERF_EVENTS
> >         LSM_HOOK_INIT(perf_event_alloc, selinux_perf_event_alloc),
> >  #endif
> > +       LSM_HOOK_INIT(lsm_config_system_policy, selinux_lsm_config_syst=
em_policy),
> > +
> >  };
> >
> >  static __init int selinux_init(void)
> > diff --git a/security/selinux/include/security.h b/security/selinux/inc=
lude/security.h
> > index e7827ed7be5f..7b779ea43cc3 100644
> > --- a/security/selinux/include/security.h
> > +++ b/security/selinux/include/security.h
> > @@ -389,7 +389,14 @@ struct selinux_kernel_status {
> >  extern void selinux_status_update_setenforce(bool enforcing);
> >  extern void selinux_status_update_policyload(u32 seqno);
> >  extern void selinux_complete_init(void);
> > +
> > +struct selinux_fs_info;
> > +
> >  extern struct path selinux_null;
> > +extern ssize_t __sel_write_load(struct selinux_fs_info *fsi,
> > +                               const char __user *buf, size_t count,
> > +                               loff_t *ppos);
> > +
> >  extern void selnl_notify_setenforce(int val);
> >  extern void selnl_notify_policyload(u32 seqno);
> >  extern int selinux_nlmsg_lookup(u16 sclass, u16 nlmsg_type, u32 *perm)=
;
> > diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.=
c
> > index 47480eb2189b..1f7e611d8300 100644
> > --- a/security/selinux/selinuxfs.c
> > +++ b/security/selinux/selinuxfs.c
> > @@ -567,11 +567,11 @@ static int sel_make_policy_nodes(struct selinux_f=
s_info *fsi,
> >         return ret;
> >  }
> >
> > -static ssize_t sel_write_load(struct file *file, const char __user *bu=
f,
> > -                             size_t count, loff_t *ppos)
> > +ssize_t __sel_write_load(struct selinux_fs_info *fsi,
> > +                        const char __user *buf, size_t count,
> > +                        loff_t *ppos)
> >
> >  {
> > -       struct selinux_fs_info *fsi;
> >         struct selinux_load_state load_state;
> >         ssize_t length;
> >         void *data =3D NULL;
> > @@ -605,7 +605,6 @@ static ssize_t sel_write_load(struct file *file, co=
nst char __user *buf,
> >                 pr_warn_ratelimited("SELinux: failed to load policy\n")=
;
> >                 goto out;
> >         }
> > -       fsi =3D file_inode(file)->i_sb->s_fs_info;
> >         length =3D sel_make_policy_nodes(fsi, load_state.policy);
> >         if (length) {
> >                 pr_warn_ratelimited("SELinux: failed to initialize seli=
nuxfs\n");
> > @@ -626,6 +625,15 @@ static ssize_t sel_write_load(struct file *file, c=
onst char __user *buf,
> >         return length;
> >  }
> >
> > +static ssize_t sel_write_load(struct file *file, const char __user *bu=
f,
> > +                             size_t count, loff_t *ppos)
> > +{
> > +       struct selinux_fs_info *fsi =3D file_inode(file)->i_sb->s_fs_in=
fo;
> > +
> > +       return __sel_write_load(fsi, buf, count, ppos);
> > +}
> > +
> > +
> >  static const struct file_operations sel_load_ops =3D {
> >         .write          =3D sel_write_load,
> >         .llseek         =3D generic_file_llseek,
> > --
> > 2.48.1
> >

