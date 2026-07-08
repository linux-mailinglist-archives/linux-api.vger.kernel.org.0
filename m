Return-Path: <linux-api+bounces-6786-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 370BGAYrTmqnEQIAu9opvQ
	(envelope-from <linux-api+bounces-6786-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 08 Jul 2026 12:48:38 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CC87247A4
	for <lists+linux-api@lfdr.de>; Wed, 08 Jul 2026 12:48:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=JWPgTIBj;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6786-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6786-lists+linux-api=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FD6730A6B2A
	for <lists+linux-api@lfdr.de>; Wed,  8 Jul 2026 10:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A929E425CE7;
	Wed,  8 Jul 2026 10:41:02 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DAF425CD2
	for <linux-api@vger.kernel.org>; Wed,  8 Jul 2026 10:40:49 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783507261; cv=pass; b=cABMjxchyNtOmbxHiZ8inO4GVZnIOSlGHs30Is1Mr9cQ4QO6QSvkDBJV3imlc42MDuwyqdS9gLnY5o0UXOYsPoD/D9GtHFWRySonHiluGS6e1qZ9BU8tfrv3zUJk1zNynpw+FpZJN5kToQZgfuOhZAHfahz0Tfx87C6D3Wu+p6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783507261; c=relaxed/simple;
	bh=YkkGe5+JQA+vJObF5DUbAYhqbFN0cqoNHaJUhIWNGZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NXk64bQdU0/ze5h4YjKXr6E6/yCA70zucyyS7UD5uTUJ98b8C6dFBCRj7C2IB/pCKj7aXpL0bBysrr/gTQOMfTthnDkoElFuehBj6rGd2BjdcP1TNozP708cO4Z5fMIc5N9NHwW0Ww6qvEUrKFbqbz5Ul1xt4Y+jzIdZI29mkOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JWPgTIBj; arc=pass smtp.client-ip=209.85.218.52
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c125bce2294so54964566b.3
        for <linux-api@vger.kernel.org>; Wed, 08 Jul 2026 03:40:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783507244; cv=none;
        d=google.com; s=arc-20260327;
        b=KOz9QAmVGgfU5ntauZO0B3B6C0nQ1hSeygdsyVkaWpELH95zwCv3NjwykRMflaRvzk
         ThdswRYx8d5ZO3GUD/AFza5qd+xrNrjPvCzgEY/PWYMS1pHImL5fSqx8Fv8AtzQC1ARP
         zlpeekT5Y5wvfwL3fNNRBUP2pGM8jV85XYwBwm6HuKUbPsHMeN/a+Ifhg1Ed18uCnMl4
         dlBh1XynH2G2idGEGpoChXeScbJ1uHfQE78c/dh/SMSXtVmUOLBbyrD/dt8pn+IxuYFg
         i+0AriteT9vKxypllTSYSx2+vBrny3RhZ797FdgztuqKjh9dHAoPhctBC5jX1gOX5Leo
         oVkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TMS3BvgnCcgwdn5c17yD5wqD6fSZDjz9Zq6YQZIe6A4=;
        fh=EiWTYRBbOVHV2eIHFDaf39J+CvdvOuzQxQ+RytOcGOY=;
        b=oeje3RN7lAwC5UrHx4Mxe+SP+boCx7ZWkI8eO8372AuRysMi286TfRGON8tEjPl9c2
         HA4kDDs3FPp5yXvDXLLB09Cju4YvXZJgZMIl34NjRTsOvoVY1YCCBsfW6OhnG6ZjjeIE
         AGFLkPdKkG4NmglDp5r8EmgGOpaW+iuGsiFr5QmGkCsmT0WlIwp6UM76TiuKaEwMWKNv
         H6cZ0w+9YeLVz3JeRI3fWAFbPRU91ax9ierokT+tvA4wa2Gkktlm6XHAFMp0B2j+6dEX
         rX5QzgH0jYhUWAYNoczCUWj7P6MhGOT49mcs3JSZyElIKnr9BdPFHvBY9GXF2WprABld
         rTNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783507244; x=1784112044; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TMS3BvgnCcgwdn5c17yD5wqD6fSZDjz9Zq6YQZIe6A4=;
        b=JWPgTIBjNAmz3/RflHP+mbzUPLCY7Z3oHcYQOXOIaPp9zbq1xqO+AlYE2OOyYCNazk
         kj2fKXR1xNk9mSzxg6jTEXFTQ4Hb2nNplvaMoZsn8gU6adwx0f7KhLlPZ6XshsJ2tL1g
         pG34JjgWEau6WL+wEpZZVDL+vIKVHH7iI1iOMV33afWJJ2VGGwGE6TGuKENbYRljNtGw
         KbusTnkI+bVmb8TvZ2S/c4S20zv2krfyecuZ/4sdP9KgE58KDVTUD/7+03rBaNyD6Rv8
         a8yW/AE+E9k68eNVZo6Kyrwso4n5/kXelFnGd9kwzhSpwUqz1Hr/qL14xamAQcmEP5mt
         KOqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783507244; x=1784112044;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TMS3BvgnCcgwdn5c17yD5wqD6fSZDjz9Zq6YQZIe6A4=;
        b=WhSkbSzYY9XBoS3AgrVINPM0e0QbmnDZBw173/1w0a0/G57E8Na5EZEgQNVkMzZpo1
         jGliiw/4MQYbeAbvwF60PCVuQbudaiJnW6KE6xXrd0eS1F+9oIVpFfpt09T7vJgDnmpl
         7Iz2h3caBl/cjGF6bUu2kchmf+KDfbXCHsKFazYJCD1XAh+p4iJgTsFZ1ArHdUOkzo3M
         OdA3J7n/3jhflqGEE6pKO0NIVwVS2HPZdGx07cqb5VY9BYe/eR5yWNZA1v/Z+xp9wStX
         W10oBIN32znmGj2GTYY+BttHIQ3EajeeYQiMY6m8aEC5cOTnkQnMZjB/jUSlwG8ZNG38
         lq/Q==
X-Forwarded-Encrypted: i=1; AHgh+RrnV15jpDkMsHfQ6Auym5vnM+7+FyY1LxqLj2mneNNbJt0CerbP/4Rgfi/WWNpndwTejtohIuHrdBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGbcaTVMhJQo1kHqgBQNHdPMBHmj2VfC3GlvXus61hNBeJF+TY
	zUV+rGjjM1p00R8V2m18fFPyu90UUXpNxY/pSleaAxR3WyQqnK7LaaeHv2X++/Wk3TXtHiyBlTt
	EElX4an0ADsxwCQ35aNTR1gfWczLRtkY=
X-Gm-Gg: AfdE7ckfgEEpHGYBGo1T4iJy5N4hq2lKRWymGByCAa3o6MQCK5vZq5Dj8Q+GVteq+jE
	g2XENYyfMV0O1oB8fdzQaJEKE7k3PkVCn+ZEBRot/xpoKNLVnFC3YDQSUl/4LNqlVtHR8Tv/2GO
	8kCFaYwLgPDkRPqOzHxAQ4G5U7Be7xJGKT0ta/s2qyq1wcoTXII85pD6lYVnkHcdMSqqsm0r7Qm
	vC6npaRJ9PgHMZ/gp6VmwFSknxu/MpGwDFJIHAytGgZk+GFeQybBpNQ8HLqkOYwzqeLa2X+Iw==
X-Received: by 2002:a17:906:9910:b0:c12:5013:4b7e with SMTP id
 a640c23a62f3a-c15cdff24b9mr66328566b.18.1783507243458; Wed, 08 Jul 2026
 03:40:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708095831.3381978-1-gscrivan@redhat.com>
In-Reply-To: <20260708095831.3381978-1-gscrivan@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 8 Jul 2026 12:40:31 +0200
X-Gm-Features: AVVi8CcOKTeSBqLQLrnrLgyZEIJXQKqNBrz3IPXb57fTGPuMcujvpl0alTuGlcs
Message-ID: <CAOQ4uxjC2JZ94r3dxJzHFFpder66biPxN-2Yy0ZeqDSyNooaPA@mail.gmail.com>
Subject: Re: [PATCH] ovl: add ioctls to retrieve layer file descriptors
To: Giuseppe Scrivano <gscrivan@redhat.com>
Cc: linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:gscrivan@redhat.com,m:linux-unionfs@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,m:mszeredi@redhat.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6786-lists,linux-api=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[amir73il@gmail.com,linux-api@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B0CC87247A4

On Wed, Jul 8, 2026 at 12:00=E2=80=AFPM Giuseppe Scrivano <gscrivan@redhat.=
com> wrote:
>
> Add two ioctls to overlay filesystem to allow userspace to retrieve
> information about the overlay layers:
>
> OVL_IOC_OPEN_LAYER:     return an O_PATH fd to the root of a layer.
>                         arg =3D=3D 0 returns the upper layer (-ENOENT if
>                         no upper is configured), arg >=3D 1 returns
>                         lower layers (-ENOENT if index is out of
>                         range).
> OVL_IOC_GET_LAYERS_INFO: copy a struct ovl_layers_info to userspace
>                         with numlower, numlowerdata, and has_upper.
>
> The ioctls work on any overlayfs file or directory and require
> CAP_SYS_ADMIN in the mounter's user namespace.
>
> The UAPI constants and struct are defined in include/uapi/linux/overlay.h=
.
>
> Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
> ---
>  MAINTAINERS                  |  1 +
>  fs/overlayfs/file.c          |  2 ++
>  fs/overlayfs/overlayfs.h     |  4 +++
>  fs/overlayfs/ovl_entry.h     |  2 ++
>  fs/overlayfs/params.c        | 10 ++++++
>  fs/overlayfs/params.h        |  1 +
>  fs/overlayfs/readdir.c       |  2 ++
>  fs/overlayfs/super.c         | 70 ++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/overlay.h | 30 ++++++++++++++++
>  9 files changed, 122 insertions(+)
>  create mode 100644 include/uapi/linux/overlay.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 25453040dffb..b64c696686e4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20368,6 +20368,7 @@ S:      Supported
>  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.g=
it
>  F:     Documentation/filesystems/overlayfs.rst
>  F:     fs/overlayfs/
> +F:     include/uapi/linux/overlay.h


overlayfs.h please

>
>  P54 WIRELESS DRIVER
>  M:     Christian Lamparter <chunkeey@googlemail.com>
> diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> index 27cc07738f33..fc9c448c5959 100644
> --- a/fs/overlayfs/file.c
> +++ b/fs/overlayfs/file.c
> @@ -649,4 +649,6 @@ const struct file_operations ovl_file_operations =3D =
{
>         .copy_file_range        =3D ovl_copy_file_range,
>         .remap_file_range       =3D ovl_remap_file_range,
>         .setlease               =3D generic_setlease,
> +       .unlocked_ioctl         =3D ovl_ioctl,
> +       .compat_ioctl           =3D compat_ptr_ioctl,
>  };
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index b75df37f70ac..10f7ef8cb78c 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -8,6 +8,7 @@
>  #include <linux/uuid.h>
>  #include <linux/fs.h>
>  #include <linux/fsverity.h>
> +#include <uapi/linux/overlay.h>
>  #include <linux/namei.h>
>  #include <linux/posix_acl.h>
>  #include <linux/posix_acl_xattr.h>
> @@ -908,6 +909,9 @@ void ovl_tempname(char name[OVL_TEMPNAME_SIZE]);
>  struct dentry *ovl_create_temp(struct ovl_fs *ofs, struct dentry *workdi=
r,
>                                struct ovl_cattr *attr);
>
> +/* super.c */
> +long ovl_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
> +
>  /* file.c */
>  extern const struct file_operations ovl_file_operations;
>  int ovl_real_fileattr_get(const struct path *realpath, struct file_kattr=
 *fa);
> diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
> index 80cad4ea96a3..b8f4bca89a27 100644
> --- a/fs/overlayfs/ovl_entry.h
> +++ b/fs/overlayfs/ovl_entry.h
> @@ -35,6 +35,8 @@ struct ovl_layer {
>         struct vfsmount *mnt;
>         /* Trap in ovl inode cache */
>         struct inode *trap;
> +       /* Keeps the original fsmount file alive for OVL_IOC_OPEN_LAYER *=
/
> +       struct file *origin;

as Miklos wrote, keep the file is an overkill

>         struct ovl_sb *fs;
>         /* Index of this layer in fs root (upper idx =3D=3D 0) */
>         int idx;
> diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
> index c93fcaa45d4a..92d1a56178f2 100644
> --- a/fs/overlayfs/params.c
> +++ b/fs/overlayfs/params.c
> @@ -482,6 +482,11 @@ static int ovl_parse_layer(struct fs_context *fc, st=
ruct fs_parameter *param,
>                         return PTR_ERR(layer_name);
>
>                 err =3D ovl_do_parse_layer(fc, layer_name, &layer_path, l=
ayer);
> +               if (!err && !is_upper_layer(layer)) {
> +                       struct ovl_fs_context *ctx =3D fc->fs_private;
> +
> +                       ctx->lower[ctx->nr - 1].origin =3D get_file(param=
->file);
> +               }
>                 break;
>         }
>         default:
> @@ -504,6 +509,9 @@ static void ovl_reset_lowerdirs(struct ovl_fs_context=
 *ctx)
>                 path_put(&l->path);
>                 kfree(l->name);
>                 l->name =3D NULL;
> +               if (l->origin)
> +                       fput(l->origin);
> +               l->origin =3D NULL;
>         }
>         ctx->nr =3D 0;
>         ctx->nr_data =3D 0;
> @@ -856,6 +864,8 @@ void ovl_free_fs(struct ovl_fs *ofs)
>         mounts =3D (struct vfsmount **) ofs->config.lowerdirs;
>         for (i =3D 0; i < ofs->numlayer; i++) {
>                 iput(ofs->layers[i].trap);
> +               if (ofs->layers[i].origin)
> +                       fput(ofs->layers[i].origin);
>                 kfree(ofs->config.lowerdirs[i]);
>                 mounts[i] =3D ofs->layers[i].mnt;
>         }
> diff --git a/fs/overlayfs/params.h b/fs/overlayfs/params.h
> index ffd53cdd8482..1d8fe8fbaca2 100644
> --- a/fs/overlayfs/params.h
> +++ b/fs/overlayfs/params.h
> @@ -22,6 +22,7 @@ struct ovl_opt_set {
>  struct ovl_fs_context_layer {
>         char *name;
>         struct path path;
> +       struct file *origin;
>  };
>
>  struct ovl_fs_context {
> diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> index e7fe29cb6028..7bab71c8bcc2 100644
> --- a/fs/overlayfs/readdir.c
> +++ b/fs/overlayfs/readdir.c
> @@ -1069,6 +1069,8 @@ const struct file_operations ovl_dir_operations =3D=
 {
>         .iterate_shared =3D shared_ovl_iterate,
>         .llseek         =3D ovl_dir_llseek,
>         .fsync          =3D ovl_dir_fsync,
> +       .unlocked_ioctl =3D ovl_ioctl,
> +       .compat_ioctl   =3D compat_ptr_ioctl,
>         .release        =3D ovl_dir_release,
>         .setlease       =3D generic_setlease,
>  };
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 60f0b7ceef0a..d143002e74b2 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -1107,6 +1107,8 @@ static int ovl_get_layers(struct super_block *sb, s=
truct ovl_fs *ofs,
>                  */
>                 mnt->mnt_flags |=3D MNT_READONLY | MNT_NOATIME;
>
> +               layers[ofs->numlayer].origin =3D l->origin;
> +               l->origin =3D NULL;
>                 layers[ofs->numlayer].trap =3D trap;
>                 layers[ofs->numlayer].mnt =3D mnt;
>                 layers[ofs->numlayer].idx =3D ofs->numlayer;
> @@ -1568,6 +1570,74 @@ int ovl_fill_super(struct super_block *sb, struct =
fs_context *fc)
>         return err;
>  }
>
> +static long ovl_ioctl_open_layer(struct file *filp, unsigned long arg)
> +{
> +       struct super_block *sb =3D file_inode(filp)->i_sb;
> +       struct ovl_fs *ofs =3D OVL_FS(sb);
> +       struct path root;
> +       struct file *f;
> +       int fd;
> +
> +       if (arg >=3D ofs->numlayer)
> +               return -ENOENT;
> +       if (arg =3D=3D 0 && !ovl_upper_mnt(ofs))
> +               return -ENOENT;
> +       if (!ofs->layers[arg].origin)
> +               return -EOPNOTSUPP;
> +
> +       root.mnt =3D mntget(ofs->layers[arg].origin->f_path.mnt);
> +       root.dentry =3D dget(root.mnt->mnt_root);
> +
> +       fd =3D get_unused_fd_flags(O_CLOEXEC);
> +       if (fd < 0) {
> +               path_put(&root);
> +               return fd;
> +       }
> +
> +       f =3D dentry_open(&root, O_PATH | O_NOFOLLOW, current_cred());
> +       path_put(&root);
> +       if (IS_ERR(f)) {
> +               put_unused_fd(fd);
> +               return PTR_ERR(f);
> +       }
> +
> +       fd_install(fd, f);
> +       return fd;
> +}
> +
> +static long ovl_ioctl_get_layers_info(struct file *filp, unsigned long a=
rg)
> +{
> +       struct super_block *sb =3D file_inode(filp)->i_sb;
> +       struct ovl_fs *ofs =3D OVL_FS(sb);
> +       struct ovl_layers_info info =3D {
> +               .numlower =3D ofs->numlayer - 1,
> +               .numlowerdata =3D ofs->numdatalayer,
> +               .has_upper =3D !!ovl_upper_mnt(ofs),
> +       };
> +
> +       if (copy_to_user((void __user *)arg, &info, sizeof(info)))
> +               return -EFAULT;
> +
> +       return 0;
> +}
> +
> +long ovl_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
> +{
> +       struct ovl_fs *ofs =3D OVL_FS(file_inode(filp)->i_sb);
> +
> +       if (!ns_capable(ofs->creator_cred->user_ns, CAP_SYS_ADMIN))
> +               return -EPERM;
> +
> +       switch (cmd) {
> +       case OVL_IOC_OPEN_LAYER:
> +               return ovl_ioctl_open_layer(filp, arg);
> +       case OVL_IOC_GET_LAYERS_INFO:
> +               return ovl_ioctl_get_layers_info(filp, arg);
> +       default:
> +               return -ENOTTY;
> +       }
> +}
> +
>  struct file_system_type ovl_fs_type =3D {
>         .owner                  =3D THIS_MODULE,
>         .name                   =3D "overlay",
> diff --git a/include/uapi/linux/overlay.h b/include/uapi/linux/overlay.h
> new file mode 100644
> index 000000000000..c92ccecd9e21
> --- /dev/null
> +++ b/include/uapi/linux/overlay.h

overlayfs.h please

> @@ -0,0 +1,30 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef _UAPI_LINUX_OVERLAY_H
> +#define _UAPI_LINUX_OVERLAY_H
> +
> +#include <linux/ioctl.h>
> +#include <linux/types.h>
> +
> +/**
> + * struct ovl_layers_info - overlay layer configuration summary
> + * @numlower:     number of lower (metadata) layers
> + * @numlowerdata: number of data-only lower layers
> + * @has_upper:    1 if an upper layer is configured, 0 otherwise
> + */
> +struct ovl_layers_info {
> +       __u32 numlower;
> +       __u32 numlowerdata;
> +       __u32 has_upper;
> +};

Whether this stays as ioctl or statmount blob

please use:

__u32 flags;
__u32 pad;

and use a flag for has_upper so we can extend this data struct in the futur=
e.

Thanks,
Amir.

