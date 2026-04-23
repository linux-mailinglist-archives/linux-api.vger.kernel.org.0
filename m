Return-Path: <linux-api+bounces-6144-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ih0lEBdv6WkzZgIAu9opvQ
	(envelope-from <linux-api+bounces-6144-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 23 Apr 2026 03:00:07 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A8344BFA7
	for <lists+linux-api@lfdr.de>; Thu, 23 Apr 2026 03:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D071830060A0
	for <lists+linux-api@lfdr.de>; Thu, 23 Apr 2026 01:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE87E239E7E;
	Thu, 23 Apr 2026 01:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMRiJS2/"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FB422CBD9
	for <linux-api@vger.kernel.org>; Thu, 23 Apr 2026 00:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776906000; cv=pass; b=evTA7n0gM93RWFMFgXjTagZWfmIm81tU71N6M5XI2L5vS3fOXSl0b/j0I34siUu+Wqxe38V0LwRxRM2QSp5UT8GPlhCoo2+UF0cfpqsAsvDVFTpqUk3OQKkS3lWek864LnC/jepKXLFZUzyfOa32yTtDaQSswG5ctrIMmS2D+9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776906000; c=relaxed/simple;
	bh=glEATcMQjgXcIVNGcFv/jGZwSA4FOZck5uTqZXkwZrk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kWfpuHiVVVN1g3FeXNCYKpIvEYNn9GutN8KL2qQGlS659hHP0+jnr3+4t5h3Q74QUJ2CcBJ2yi7aAiqLBKmwIvC0v+aMYHZ5AkAgfFzPvoI0+rg87cFecx/6Pm5vGhKWPtvC9fx9ZbmPjf9s1f6cLxCS06N+wB6fz4W1q5EwTuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YMRiJS2/; arc=pass smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8a049a767c3so72750156d6.1
        for <linux-api@vger.kernel.org>; Wed, 22 Apr 2026 17:59:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776905997; cv=none;
        d=google.com; s=arc-20240605;
        b=H0us3HDEHcK1pZBXXxi1t3SXj3j6oRvaSaecE7g7Nnik6st+yHgSszu02CL1udCmK3
         92Erc3pGuo8vQElXks1lORcBRy1YXiIoYo1h6TMuxOWGceCsHBHw15IdQEQ1wY4IVzr/
         I29w/qMbTq7AIK1QqpHY5QRvoTtk11IcUs+zIh4fs+QvGjgHupWU4X4KpOFOmyD06Er1
         9j57mJokDIuI3uHbyhPfqXkw/wGMxaFb0ugy8QJVc29IuXm4lK75jVSMxWY2i70tWZTM
         f28BIbHua6Qt8MUstgLV2S/ymS70j3KxCkZ7JupnCUPdGRaGdhpf0PiVEY2hVwRXzCh2
         Q/ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t/Auuo3ewU9oR2gX8cwKFh7CPK/qOcoVmyN6PErL6wA=;
        fh=F49BC2O4M8xoHT0mSbnMg5hea2H8AbR8wjohb54+bKs=;
        b=g2HgRCv7HmvGhBbsIGuNClcMYLcZlkZdBpMyKyFDv3+I7YbYO2+06qXtsWzrWby5yT
         A83GnQmExKwYBcA6YOTUgGZdDKVaAkFkR6RO6SIomGERcSNd71e1iKNm7RpWyIMKVwXy
         T3kJ5lfZsFvHe4OS+G95OQ/zk5DWot8Ld0ZLExWHoYtXGvzLyxarQ22jk6Y7DoZYA601
         YsOhhzlZxJr6PQ4526YFXydIqUyzClG5YbIDvUSc5EROLG7qPeSRJYj3p6tZyd6sP4x/
         ZPVCqJ1MwomIdMtUnmrAeGGVbgOgEAMnWX8VZJcNblDK2dSmDH95jiN1IjshG50OpqHb
         xzfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776905997; x=1777510797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/Auuo3ewU9oR2gX8cwKFh7CPK/qOcoVmyN6PErL6wA=;
        b=YMRiJS2/7iPeV6CGivmFNZlhKtWjZPgsedWvhWP74UAv3lHrFmEFD0Aur6BIskzh0g
         QWBYcqG55fzdQVfvpnQ9RV5vQsjz0rWZL56X2ebc3clKJU48exG+EENE6kbVBxOFpPk+
         5t2gNgAxnqyaIvLY5ck4yRXX+nydQgvVrTEgBY8JAQXSqA8G3K6ongzaSlOAcv5LE5uM
         Yo7Lct+7ITiCGlvIXN81wLh8Pdlp3XWrN5vkapIFlpVoCanONo4VVCoHnyFslJtMBaWb
         mcFu62lehj3ZRz/Tw8nwq2iDe7aP0WaWjUg+TjiMd5pr/GNJgLYryCDxWm3FILghrLh2
         OYZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776905997; x=1777510797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t/Auuo3ewU9oR2gX8cwKFh7CPK/qOcoVmyN6PErL6wA=;
        b=IaSvGY0O3GgLGT+pOxa8wfTisC8y6UO1w5IkpM+0XaC8mTUZ/kpEAtW3zEN0lUnZmB
         TtzF3PFK/yrSbFg1SGRIzLmA6Tje/uX0IFbKyaUI0uKQPk/RJYofpFbIjAuGjJQemjSv
         z71qfwFyKsaSEXnN/A0eF3Tjmdwwez1I0u7tQnzgrSNWYVykNHHsgUHFh5wcbF0isl9l
         U0bhZAPSZGAWmfzT1eB9mQqsz6eAF6T/joYCFvQvszVFDBU8zEGG0g5KqNiVvKXjFdfF
         24vgtFw0koyRaV3OnSVGKgllo9GeCpHNxDvYvMqJzwFxQ9KgLOpElPqjdY1+ypiEc3Y9
         SASA==
X-Forwarded-Encrypted: i=1; AFNElJ/g6mhWMNzXJknRJ+wc1eri9sIzVVQwApTP87RtRgONl+QRRUModPtL4M+eHXHKjjMugmhJiDqCwOE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtaafswEdlOIyJGJnJ6qHXd1gR/o0aPzHDUlVoWLc9plzfFQTo
	HILiWejyh3vaj1HtOV0KEgxqyu8X72wfkgPM+uoXhOx3LoWBJovvSYyB3nI+G2Cl37B8o5dx6Ul
	a0R7y3h4ZGZI79J8pFv6nDGlT2IYrohk=
X-Gm-Gg: AeBDievMvg+R2ZJWZSVaWCWin5W3rhQZJYORArV+NykVqcNvyJ8c6wmRCVmb2GCBsUF
	28mnGfnK8Hjw0EX5csvYOZFi9MKceBiSbcacjUZhd/5zjhrG52ow0mW3/N1bECi8NEJ16cz1WFr
	DayV7zMW49fmKIDvOecT+qPNcKrdSbo0z5cCGg6KS/NWx6JeDLQDbLY1X+Ub1thkk9DMpJQrTBW
	tQS9RITIfEU1KYSEvnSC5rSkFBneCaCnMvGnA6TVz7zdbkoCW6blQfRQ6kd8oRSCRfXTB52/uh6
	t9Tkxg76AfrE+1z0gjc73ZLL/UUomKXAP3+0kxaXC69qFFbrzNugtcSpc3wyw2norGGuluirDUS
	4J+9J3phAgpKB06BtV9yWrNVBXkJmjpHX0BkHbaoK6UN8H0qQJ2J8e35RGOMJ6vmvClOmXoaXDY
	quctnCibJ4FF2zFWLMhNuriQ9mJ6tZvK+AfvaXTbDi5Co=
X-Received: by 2002:a05:6214:490a:b0:8ac:b3ba:eb0c with SMTP id
 6a1803df08f44-8b0282f35c0mr336785626d6.2.1776905997499; Wed, 22 Apr 2026
 17:59:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422-case-sensitivity-v9-0-be023cc070e2@oracle.com> <20260422-case-sensitivity-v9-10-be023cc070e2@oracle.com>
In-Reply-To: <20260422-case-sensitivity-v9-10-be023cc070e2@oracle.com>
From: Steve French <smfrench@gmail.com>
Date: Wed, 22 Apr 2026 19:59:43 -0500
X-Gm-Features: AQROBzCtyORnfuVHnIm1n6WO0qai8y2HQyRw138-ozkefgToPmyDNAGdDckhKog
Message-ID: <CAH2r5muvUVY8FD6ZM+ARecM8evjejB15n0Ea9Z=GGn=i5aKFNA@mail.gmail.com>
Subject: Re: [PATCH v9 10/17] cifs: Implement fileattr_get for case sensitivity
To: Chuck Lever <cel@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, hirofumi@mail.parknet.co.jp, 
	linkinjeon@kernel.org, sj1557.seo@samsung.com, yuezhang.mo@sony.com, 
	almaz.alexandrovich@paragon-software.com, slava@dubeyko.com, 
	glaubitz@physik.fu-berlin.de, frank.li@vivo.com, tytso@mit.edu, 
	adilger.kernel@dilger.ca, cem@kernel.org, sfrench@samba.org, pc@manguebit.org, 
	ronniesahlberg@gmail.com, sprasad@microsoft.com, trondmy@kernel.org, 
	anna@kernel.org, jaegeuk@kernel.org, chao@kernel.org, hansg@kernel.org, 
	senozhatsky@chromium.org, Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6144-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[smfrench@gmail.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 34A8344BFA7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Acked-by: Steve French <stfrench@microsoft.com>

Do you know which xfstests this would enable?  IIRC a few of them
depend on the fs supporting fileattr_get

On Wed, Apr 22, 2026 at 6:34=E2=80=AFPM Chuck Lever <cel@kernel.org> wrote:
>
> From: Chuck Lever <chuck.lever@oracle.com>
>
> Upper layers such as NFSD need a way to query whether a filesystem
> handles filenames in a case-sensitive manner. Report CIFS/SMB case
> handling behavior via the FS_XFLAG_CASEFOLD flag.
>
> CIFS servers (typically Windows or Samba) are usually case-insensitive
> but case-preserving, meaning they ignore case during lookups but store
> filenames exactly as provided.
>
> The implementation reports case sensitivity based on the nocase mount
> option, which reflects whether the client expects the server to perform
> case-insensitive comparisons. When nocase is set, the mount is reported
> as case-insensitive.
>
> The callback is registered in all three inode_operations structures
> (directory, file, and symlink) to ensure consistent reporting across
> all inode types.
>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/smb/client/cifsfs.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
> index 2025739f070a..9b70ffa3e01d 100644
> --- a/fs/smb/client/cifsfs.c
> +++ b/fs/smb/client/cifsfs.c
> @@ -30,6 +30,7 @@
>  #include <linux/xattr.h>
>  #include <linux/mm.h>
>  #include <linux/key-type.h>
> +#include <linux/fileattr.h>
>  #include <uapi/linux/magic.h>
>  #include <net/ipv6.h>
>  #include "cifsfs.h"
> @@ -1199,6 +1200,22 @@ struct file_system_type smb3_fs_type =3D {
>  MODULE_ALIAS_FS("smb3");
>  MODULE_ALIAS("smb3");
>
> +static int cifs_fileattr_get(struct dentry *dentry, struct file_kattr *f=
a)
> +{
> +       struct cifs_sb_info *cifs_sb =3D CIFS_SB(dentry->d_sb);
> +       struct cifs_tcon *tcon =3D cifs_sb_master_tcon(cifs_sb);
> +
> +       /*
> +        * The nocase mount option installs case-insensitive dentry
> +        * operations on this superblock. SMB preserves case on the
> +        * wire and at rest, so the mount matches FS_XFLAG_CASEFOLD
> +        * semantics: case-folded lookup, verbatim storage.
> +        */
> +       if (tcon->nocase)
> +               fa->fsx_xflags |=3D FS_XFLAG_CASEFOLD;
> +       return 0;
> +}
> +
>  const struct inode_operations cifs_dir_inode_ops =3D {
>         .create =3D cifs_create,
>         .atomic_open =3D cifs_atomic_open,
> @@ -1217,6 +1234,7 @@ const struct inode_operations cifs_dir_inode_ops =
=3D {
>         .listxattr =3D cifs_listxattr,
>         .get_acl =3D cifs_get_acl,
>         .set_acl =3D cifs_set_acl,
> +       .fileattr_get =3D cifs_fileattr_get,
>  };
>
>  const struct inode_operations cifs_file_inode_ops =3D {
> @@ -1227,6 +1245,7 @@ const struct inode_operations cifs_file_inode_ops =
=3D {
>         .fiemap =3D cifs_fiemap,
>         .get_acl =3D cifs_get_acl,
>         .set_acl =3D cifs_set_acl,
> +       .fileattr_get =3D cifs_fileattr_get,
>  };
>
>  const char *cifs_get_link(struct dentry *dentry, struct inode *inode,
> @@ -1261,6 +1280,7 @@ const struct inode_operations cifs_symlink_inode_op=
s =3D {
>         .setattr =3D cifs_setattr,
>         .permission =3D cifs_permission,
>         .listxattr =3D cifs_listxattr,
> +       .fileattr_get =3D cifs_fileattr_get,
>  };
>
>  /*
>
> --
> 2.53.0
>
>


--=20
Thanks,

Steve

