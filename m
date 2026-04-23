Return-Path: <linux-api+bounces-6165-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKj0OCeJ6mnU0QIAu9opvQ
	(envelope-from <linux-api+bounces-6165-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 23 Apr 2026 23:03:35 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C534579CA
	for <lists+linux-api@lfdr.de>; Thu, 23 Apr 2026 23:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C2935301E996
	for <lists+linux-api@lfdr.de>; Thu, 23 Apr 2026 21:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7852B359A7C;
	Thu, 23 Apr 2026 21:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rDvAu1SN"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E3334C130
	for <linux-api@vger.kernel.org>; Thu, 23 Apr 2026 21:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776978191; cv=pass; b=mOVsjcwQpZNse6STXPcPSeqWGhtoisAyAThJY92rBlBOcYgpJ80u3aVIwFI2P35LSWfgtNyKsoqoMWkNucIdjgY/JGMMq4lsh5neSYFEaIE+KaxgrSWVvuK6BGZsJLGwxpefIFQO8+0XEgEZkKsBBFs6hBHteh8FHERL2rdtkMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776978191; c=relaxed/simple;
	bh=xhEH603J8v85yHWTGq8ZnN7Uus4HM3riSO2QoNgy+fs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MfbrZT47ZvPN9hvTbUyLuBFYyZh3Ev8C1qj1AhK8nVe1MwMZkAQBHZ7+94C5Kfe2tiZXYTT9Yl4Q95mg0hH59sfmQVEECZIkwIth1VPKlIF2UzGk2znGSEK7xI8WVCsKjH8wsk3N2qzSkE+UuwcOLoYmykmMUSqCNQd5o0lEBrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rDvAu1SN; arc=pass smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8acae26e564so81121316d6.2
        for <linux-api@vger.kernel.org>; Thu, 23 Apr 2026 14:03:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776978188; cv=none;
        d=google.com; s=arc-20240605;
        b=BKF8f22hr8w/V2+JrH4db4BlCBy3fnS47/7m0IPRwDuOS7LU3nUPLKVz3YnIRBsZKw
         E1JhutI7UMi95b9dbhGJhqbZJJRvzDmlq1Xo/ebXpWQDl4vNDKFxlJCKGbBxKvmaNUCm
         hx/hbfH+N4thjyYfkmVoqHWl+VsuaChyZc0M0fl/X6QZQi7KQTr0CnMEK0gXyg5WqhPb
         fPz3sTXQid91w51nsE1CRTqtkLiwCXxI6pDYpdzaeUVDjFFAqCj8rteN+iNaQw372JZH
         OeGAIU1g0Fb1jrcocvfCugBm73c1+4+vkAdyjW+ctoQVMPqeRppzsc4sLY90hy1qaxsm
         MtXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PB9D2kfgkJFOe3p8pXvyrrOYHUrSUtT15eUJWPkJgQk=;
        fh=yt0TNsQg/OKQeGsokdjg+CVtq38DJ2MgbtS9FaIf11E=;
        b=kZz1Ni40DraPydNwa9kAq2NfPF9D+r6wQ+7ug/n8VdSxqdkU8sEaYT8ockTZdqqBM6
         hbuJqa5ggRtY7ht4CTfTRZXe6KsSf7TUGlv5jZ4M8TOODCTIe9WF85KPtaVmQnhEwA7w
         n4etzOwYlY5uR2otqPcGwQZl3pu9hMTX4Lh/SEww8mu9Fk7++bKOuKUknbijQdR73lDV
         H49w4px15c7tEJDU102eSCwirYFz6rYnngvX5kvThHU/dtKCwjdqhhuMadAft6c10rGA
         FJzK1fxNdgEZ0rhmVpj4c4KJrdXm7g+mAsK1pmrbhxbcWcehmuaC03e5dug8IQ0hjiw7
         k8KQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776978188; x=1777582988; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PB9D2kfgkJFOe3p8pXvyrrOYHUrSUtT15eUJWPkJgQk=;
        b=rDvAu1SNNCNFOtPGGZA1Ilm0Le5RC3HqJ0wXokdqmzOLVNi8lHw7GMMZu9w9TKLwL2
         97WG5/8zvZHB8yvJKvWest8upLdKisDZ7H05Ka5/vdYNhsrnM3D9ri/hCBGJJWSYMJ6A
         4aV5pN8ZpW+OvUAVyQXtCxyz+lKlPQ3JSP3K8P+ESur67eGHrRIzYUzsXwVHkCd6yj2/
         ctzXdJjsBXDJTbKbibVy0FNHQzCBCqmL0wFBtBXUGYA9rjTxlgcuc+yyfB6WixhGhej1
         k1hqtskE52BY3YNgHMeEYZ4kRq1QB4GqeTj/Zh+a80rccrsXdmSCnU6wEvXr81Y4Mp/o
         /xVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776978188; x=1777582988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PB9D2kfgkJFOe3p8pXvyrrOYHUrSUtT15eUJWPkJgQk=;
        b=A0v810kqHT9arp3OUCj2vxPtSJHnnN5As7OxyO7sa8ACwkSbQNJ9tb/MQV/GILAWs6
         zpju4y89wR4iZXSBIx16cYUtRYrJXzYAQIO/GwD8HzSTYInWCOk/VjKWJLqmUrlUWnnJ
         YC0vRERGBRNTYfH8hxBCNBgxdpNMHjAKlfJSpRvkawCI+dQBQH2RcENNMzFClXEGEQVs
         h9JA71LqDkBEfMDUDyOrM0u5p1uMPo8BemAvKJszy5NsqBbfwJlEbxuZ83jecSFdNm/J
         i8RK1KFFiTlhHEF5fsTOUJYk8yGVe7zqj1Vkia5cew8Vmg+/zzVh/VLkqAYK5Ka67qwp
         ofiA==
X-Forwarded-Encrypted: i=1; AFNElJ8aal9M3TfNKHofz89hKscwIlqXXwX4oyxrrNFHKFtIuIXVCxaI+jpRrhU15ubrd6ywoL6lKVplRp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW1JgRVU/CtHOd3QsUdarA8wvbXHOf8VZStquGRn9otPuLgHmF
	mSR01pImSMtt9Vnvb+dnZ9BCdglb2Li/SiwEjRmggs2TZY0tvJOe2sdKD54pUBT/dnY0aQLbtLu
	Y0nLrkU0CR2R/+fZw7ndvs+ePAWcXsCw=
X-Gm-Gg: AeBDieuFcy21wq/49jAGGIRBTx0AUldb2QKmx89t71g00X6z7Rs41ZiO9iqeTwOxt0j
	RhWLrlWbmy/c+YepvZHQfbVEw9f2tjKR0GXsOnYXhDDRbZYzBomPnyJSLs80qt4FcRIC0puc6sX
	d3zvp7LCMH86gJ9/AbQeqY5vO0AEfoOqFGzjB5A5WC6m4xPXiBu9vWxzM1IgGNOtYJa5rAfGRMm
	izZ3eiyTL7/VCPNXNi6x4Vm445/yqMsSaW0/cBfttG9RSA9lqxFm0BwxtJjcjyJcl1RmgXw3YM3
	FV77ic1PMniSvPE9e21ZDBJ0irpngQucNjKfLm7EWMPMDUL/Metkm6Dzkc0q9eSptLtLSnXvUsC
	HhdTpYODyf1pCVKkEGdiyWEWJACgsdSkPhdxFvpcO2cQ1BNbqfMEq29eNEWpUaCNS3veEsYN6iE
	K1a1gPYZDXYguIz/XKk2twhvdBNRqr5mg=
X-Received: by 2002:ad4:5d65:0:b0:8ae:6282:df2e with SMTP id
 6a1803df08f44-8b02822456emr461252066d6.44.1776978187970; Thu, 23 Apr 2026
 14:03:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260423-case-sensitivity-v10-0-c385d674a6cf@oracle.com> <20260423-case-sensitivity-v10-10-c385d674a6cf@oracle.com>
In-Reply-To: <20260423-case-sensitivity-v10-10-c385d674a6cf@oracle.com>
From: Steve French <smfrench@gmail.com>
Date: Thu, 23 Apr 2026 16:02:56 -0500
X-Gm-Features: AQROBzDF43-id-Qgk6rRbL0HPyUPTg1w8GYo4-J0uBb2d6IfD5ElWAtE-TtbFxA
Message-ID: <CAH2r5mu1Wg_9tZCjei-xF357UjKR+h6jQr9zey39v59rx9quZQ@mail.gmail.com>
Subject: Re: [PATCH v10 10/17] cifs: Implement fileattr_get for case sensitivity
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
	senozhatsky@chromium.org, Chuck Lever <chuck.lever@oracle.com>, 
	Steve French <stfrench@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6165-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[smfrench@gmail.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 62C534579CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Should this also be checking if the SMB3.1.1 Linux Extensions or SMB
POSIX Extensions are negotiated (ie the server supports case
sensitivity)?

On Thu, Apr 23, 2026 at 8:20=E2=80=AFAM Chuck Lever <cel@kernel.org> wrote:
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
> Acked-by: Steve French <stfrench@microsoft.com>
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

