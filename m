Return-Path: <linux-api+bounces-6059-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EyPNqPR02m6mgcAu9opvQ
	(envelope-from <linux-api+bounces-6059-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 06 Apr 2026 17:30:43 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A0B3A4BB2
	for <lists+linux-api@lfdr.de>; Mon, 06 Apr 2026 17:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 27D7D3014519
	for <lists+linux-api@lfdr.de>; Mon,  6 Apr 2026 15:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023CA2DFA4A;
	Mon,  6 Apr 2026 15:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/BLFVNZ"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E956231A23
	for <linux-api@vger.kernel.org>; Mon,  6 Apr 2026 15:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775489438; cv=pass; b=Jd1pdCNavKvmPvq4QC9Zu6Fo0bNFqXHQOO5cBu0oK1IgJX9bZ8mABGbp0VNooh6s+AVg01KgUzXUfRpmSfZ3b2le21s9sC7KzjIVG32d+NLkbyUeW0RGQ9yfmOQcDWysfOLvyaqeq6TT0G/9gKjJlBVnzKqcgYmap87aRfGYD0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775489438; c=relaxed/simple;
	bh=8zJQSfCdR/mcIEQjJXvhWGmmUar4tzWhYvw9NlI3l4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JTbElzrSaunEx1AsFdIqyfN3oN7nTtDpmVo89B+Z9fX/7RMiFkwEWvo6OV4jKft7Ej/lP9IA1hKOA+zOby8DgP9jvOg0bpncKQgxj9tLELYFJ39O9DDdQRL87O+UoLsX8C1jOqhnWQtpbsxoTdpbEzf8nhKJln4eVliDKWrYQuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/BLFVNZ; arc=pass smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5637886c92aso1781472e0c.0
        for <linux-api@vger.kernel.org>; Mon, 06 Apr 2026 08:30:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775489435; cv=none;
        d=google.com; s=arc-20240605;
        b=MRAtx1U7KsP9Y0HPiNvKQz80M4tr+Kv5JfLloefcdRAUlQ+5G5B2lsXmswIU/9b5aC
         esSyAgxsD+t51HLanLzKCZ67/uWMjgDBAm3gp9hguVDGXG7UQAPDzDk4LVYqprej3YQC
         Swbbmbu2wzkB012dEzTKgK1noAL43b/tYwPihXvzrDCifdL0/BFBq4AQV2Pg1Ieh7Pdq
         +zl798pLeWM/BFQCJpjXY1PnjU2gMBejUpG5IFY4csgFQymi3b4g36dhQGOMEq3WWt7N
         5YAxD1hZo17ovTTJGDSM/Zu04ibdeHFTb8PcTGMRgH1mH2Tsc6aytV/PkwEwF3QX8p9G
         /1oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G1amhMj7VQwFQNPvQJarjbd/X8oBkC8CtRCfdTYoWYI=;
        fh=H1VnURzToBJMu7CxJbMl6HIlQsKWCR+lVX0o3FSNYKs=;
        b=EdpUBPrDuP7KOPw0muk7xu0ZYqkvJ01XC4ox5kl8B/LYX6VwPFYUINGE7cEIIff0Ba
         5UUr8eCHvLGvDAW2SqxipB1vycCzwyW82laBy7bDzWs+JhSUL4aFWu3Q9nVRY2qz4H3z
         7cAb6JWy2wh7ovsbjGjPUkwO/ErpKdrKrAushG5FoCh7CpdjYQVRiwn1r4RTkbEtm+yO
         xiYah0wKnUib5GBVSfa8hyZdbxrPBh5Xeq1MlXKPUnRQarfEvSLJYibnDNGzlQHrmPPp
         5MdN36YhHW8KvJN7yCGMIydwMzZwFTPp42+UEpjv0t+QfWg5GAWbNA4nmYVNyG7NZaul
         PWUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775489435; x=1776094235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G1amhMj7VQwFQNPvQJarjbd/X8oBkC8CtRCfdTYoWYI=;
        b=X/BLFVNZBHEIi033kgG6qlCzbZOTSBCg65NpP9EeYzoCd9vb/2S25O/9yNJQl8N/Fm
         JoVSX2Kr3QQkRRIL0W5IIn4gQRmoN5XMiX6DwIuHzEzi1LOkm2R0ODZE3k0lRj5990zy
         wAVVN9643WlxwYP+WYlMUHDOVpJbHl6kBKqsmNyO3F2omOFl97P5nMmoYEtPotS2xB7V
         B/MqIEHH6HzNzeq8V7krbw5xppbCUiYRuzzNXUuSchZupnVZBbZKYw2lI1b/HMAhbfhm
         QKgSrFtVZUYdhqGBPY50SCfOKIUAE0xAn4/+roh7/UMzmLkMa0Uv0O572Q7CHKRDI0RI
         2Mvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775489435; x=1776094235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G1amhMj7VQwFQNPvQJarjbd/X8oBkC8CtRCfdTYoWYI=;
        b=PPnoD3tWEeSnFOE5+/YtKy1DNpBcJbO+I2NC9olA4LMXBixEbyABz/YpfV4E53pcK5
         FKp4OTqmNi8X+ubE5vM/elIUf9OSrXq9mynLYSWyukdyQc72uzet0YfTSxKVvl2K3COJ
         Ebcl8XnJqpUuUerH2tsF1mK5nxjgNpVHxXwik6Ost3IOYa338rWJQgOEs9YuZw4il0Rs
         sYWED9soT7wpghRznTgInllVp13L/rphjrLgmviDbZaMB6hT8m8yEs7pDIGXmmWDWvKa
         0U45un25FsjJo0OeHhRDoEq8Mt8F0ZCUPSwhmK/LAMx/l0H36Cf4ZoyAk/k2HkX4dL7t
         2ApA==
X-Forwarded-Encrypted: i=1; AJvYcCXwz9VkNuj5zpycETiYIu6dGoJjcebTKZpBdo7EFtPiVhByIqeh+hsrGoimuzVRfPD/EGxNDRLhG+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPTi2L6oSkrjIULLbu0hH28zg3G/nHjI1Gd31dsGlHHwvmGDWs
	X7L1DOmN6Zt8whR71lnaJw8iSAP3zQUwtJKPQ22XxTap5VNHbbcEmjIt5vPT0lmrf+6q/9PwYyT
	TPv5ZAJEHFgcT4vIqtlOZJit9tZOixLI=
X-Gm-Gg: AeBDieuR2t/ZeMUN3xHwwjOGroDY510mdpLmggJ9UWOBGMHbNPoYj0GkKKMHTH9NyQ3
	1Po9tqIRPuzbq3Nd7/SBGwidQt1rP6FqZyKjAILHSYWxBhCDgMDXawucDl+EnOb2v3GD6XTRuIg
	jDNEUsQEQ8nmva2q7vgPErVanVPVtlcsaNzBHYPx3lx9udgD4VcP+TnA1I9UJ6D+QKf1xrXIUNi
	OFqGxoxta7mK1w01g7PuKICyeUWlVQyVEB9JLS2elFKsoaWeEbb7cqCAxJAj0orUYdws4IUH9Qz
	qwdYfwvwB0zqjkB1fwgrbZcdyVwb6ATWHrMd2cgx3kM=
X-Received: by 2002:a05:6102:c87:b0:5ff:ed38:187a with SMTP id
 ada2fe7eead31-605a4cd8c79mr4202146137.5.1775489435216; Mon, 06 Apr 2026
 08:30:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260328172314.45807-1-dorjoychy111@gmail.com>
 <20260328172314.45807-2-dorjoychy111@gmail.com> <e526fbdb450a593b575355c1c9ae21f286427275.camel@kernel.org>
 <CAFfO_h75dF2s83VNtUaNuRmto1NVVcxo7kN6eAtNtN3ME8mPiQ@mail.gmail.com>
 <4385168f2147efb8131d5fe4209e88d2d15a60bf.camel@kernel.org>
 <CAFfO_h4dhsXji=+FjO9EikX0_oUUDkWe8tC1F7u4WqhNAjRB=g@mail.gmail.com> <ce36e877adf7a639bc4e61090d148c06fed63bf7.camel@kernel.org>
In-Reply-To: <ce36e877adf7a639bc4e61090d148c06fed63bf7.camel@kernel.org>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Mon, 6 Apr 2026 21:30:24 +0600
X-Gm-Features: AQROBzCtxxZfw03_eEcv5twToRFl64wdeIdKpjArPWT8rCpTJ0OD9nA2C0XX0Z8
Message-ID: <CAFfO_h5FOTv-VMbh2Dmwkp04BFxQu192gsvFLohDFXAWPccRNA@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] openat2: new OPENAT2_REGULAR flag support
To: linux-fsdevel@vger.kernel.org, brauner@kernel.org
Cc: Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	chuck.lever@oracle.com, alex.aring@gmail.com, arnd@arndb.de, 
	adilger@dilger.ca, mjguzik@gmail.com, smfrench@gmail.com, 
	richard.henderson@linaro.org, mattst88@gmail.com, linmag7@gmail.com, 
	tsbogend@alpha.franken.de, James.Bottomley@hansenpartnership.com, 
	deller@gmx.de, davem@davemloft.net, andreas@gaisler.com, idryomov@gmail.com, 
	amarkuze@redhat.com, slava@dubeyko.com, agruenba@redhat.com, 
	trondmy@kernel.org, anna@kernel.org, sfrench@samba.org, pc@manguebit.org, 
	ronniesahlberg@gmail.com, sprasad@microsoft.com, tom@talpey.com, 
	bharathsm@microsoft.com, shuah@kernel.org, miklos@szeredi.hu, 
	hansg@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6059-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[42];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.linux.dev,zeniv.linux.org.uk,suse.cz,oracle.com,gmail.com,arndb.de,dilger.ca,linaro.org,alpha.franken.de,hansenpartnership.com,gmx.de,davemloft.net,gaisler.com,redhat.com,dubeyko.com,samba.org,manguebit.org,microsoft.com,talpey.com,szeredi.hu];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.979];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dorjoychy111@gmail.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 56A0B3A4BB2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 6, 2026 at 5:27=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> On Sat, 2026-04-04 at 21:17 +0600, Dorjoy Chowdhury wrote:
> > On Thu, Apr 2, 2026 at 1:02=E2=80=AFAM Jeff Layton <jlayton@kernel.org>=
 wrote:
> > >
> > > On Mon, 2026-03-30 at 21:07 +0600, Dorjoy Chowdhury wrote:
> > > > On Mon, Mar 30, 2026 at 5:49=E2=80=AFPM Jeff Layton <jlayton@kernel=
.org> wrote:
> > > > >
> > > > > On Sat, 2026-03-28 at 23:22 +0600, Dorjoy Chowdhury wrote:
> > > > > > This flag indicates the path should be opened if it's a regular=
 file.
> > > > > > This is useful to write secure programs that want to avoid bein=
g
> > > > > > tricked into opening device nodes with special semantics while =
thinking
> > > > > > they operate on regular files. This is a requested feature from=
 the
> > > > > > uapi-group[1].
> > > > > >
> > > > > > A corresponding error code EFTYPE has been introduced. For exam=
ple, if
> > > > > > openat2 is called on path /dev/null with OPENAT2_REGULAR in the=
 flag
> > > > > > param, it will return -EFTYPE. EFTYPE is already used in BSD sy=
stems
> > > > > > like FreeBSD, macOS.
> > > > > >
> > > > > > When used in combination with O_CREAT, either the regular file =
is
> > > > > > created, or if the path already exists, it is opened if it's a =
regular
> > > > > > file. Otherwise, -EFTYPE is returned.
> > > > > >
> > > > > > When OPENAT2_REGULAR is combined with O_DIRECTORY, -EINVAL is r=
eturned
> > > > > > as it doesn't make sense to open a path that is both a director=
y and a
> > > > > > regular file.
> > > > > >
> > > > > > [1]: https://uapi-group.org/kernel-features/#ability-to-only-op=
en-regular-files
> > > > > >
> > > > > > Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> > > > > > ---
> > > > > >  arch/alpha/include/uapi/asm/errno.h        |  2 ++
> > > > > >  arch/alpha/include/uapi/asm/fcntl.h        |  1 +
> > > > > >  arch/mips/include/uapi/asm/errno.h         |  2 ++
> > > > > >  arch/parisc/include/uapi/asm/errno.h       |  2 ++
> > > > > >  arch/parisc/include/uapi/asm/fcntl.h       |  1 +
> > > > > >  arch/sparc/include/uapi/asm/errno.h        |  2 ++
> > > > > >  arch/sparc/include/uapi/asm/fcntl.h        |  1 +
> > > > > >  fs/ceph/file.c                             |  4 ++++
> > > > > >  fs/fcntl.c                                 |  4 ++--
> > > > > >  fs/gfs2/inode.c                            |  6 ++++++
> > > > > >  fs/namei.c                                 |  4 ++++
> > > > > >  fs/nfs/dir.c                               |  4 ++++
> > > > > >  fs/open.c                                  |  8 +++++---
> > > > > >  fs/smb/client/dir.c                        | 14 +++++++++++++-
> > > > > >  include/linux/fcntl.h                      |  2 ++
> > > > > >  include/uapi/asm-generic/errno.h           |  2 ++
> > > > > >  include/uapi/asm-generic/fcntl.h           |  4 ++++
> > > > > >  tools/arch/alpha/include/uapi/asm/errno.h  |  2 ++
> > > > > >  tools/arch/mips/include/uapi/asm/errno.h   |  2 ++
> > > > > >  tools/arch/parisc/include/uapi/asm/errno.h |  2 ++
> > > > > >  tools/arch/sparc/include/uapi/asm/errno.h  |  2 ++
> > > > > >  tools/include/uapi/asm-generic/errno.h     |  2 ++
> > > > > >  22 files changed, 67 insertions(+), 6 deletions(-)
> > > > > >
> > > > > > diff --git a/arch/alpha/include/uapi/asm/errno.h b/arch/alpha/i=
nclude/uapi/asm/errno.h
> > > > > > index 6791f6508632..1a99f38813c7 100644
> > > > > > --- a/arch/alpha/include/uapi/asm/errno.h
> > > > > > +++ b/arch/alpha/include/uapi/asm/errno.h
> > > > > > @@ -127,4 +127,6 @@
> > > > > >
> > > > > >  #define EHWPOISON    139     /* Memory page has hardware error=
 */
> > > > > >
> > > > > > +#define EFTYPE               140     /* Wrong file type for th=
e intended operation */
> > > > > > +
> > > > > >  #endif
> > > > > > diff --git a/arch/alpha/include/uapi/asm/fcntl.h b/arch/alpha/i=
nclude/uapi/asm/fcntl.h
> > > > > > index 50bdc8e8a271..fe488bf7c18e 100644
> > > > > > --- a/arch/alpha/include/uapi/asm/fcntl.h
> > > > > > +++ b/arch/alpha/include/uapi/asm/fcntl.h
> > > > > > @@ -34,6 +34,7 @@
> > > > > >
> > > > > >  #define O_PATH               040000000
> > > > > >  #define __O_TMPFILE  0100000000
> > > > > > +#define OPENAT2_REGULAR      0200000000
> > > > > >
> > > > > >  #define F_GETLK              7
> > > > > >  #define F_SETLK              8
> > > > > > diff --git a/arch/mips/include/uapi/asm/errno.h b/arch/mips/inc=
lude/uapi/asm/errno.h
> > > > > > index c01ed91b1ef4..1835a50b69ce 100644
> > > > > > --- a/arch/mips/include/uapi/asm/errno.h
> > > > > > +++ b/arch/mips/include/uapi/asm/errno.h
> > > > > > @@ -126,6 +126,8 @@
> > > > > >
> > > > > >  #define EHWPOISON    168     /* Memory page has hardware error=
 */
> > > > > >
> > > > > > +#define EFTYPE               169     /* Wrong file type for th=
e intended operation */
> > > > > > +
> > > > > >  #define EDQUOT               1133    /* Quota exceeded */
> > > > > >
> > > > > >
> > > > > > diff --git a/arch/parisc/include/uapi/asm/errno.h b/arch/parisc=
/include/uapi/asm/errno.h
> > > > > > index 8cbc07c1903e..93194fbb0a80 100644
> > > > > > --- a/arch/parisc/include/uapi/asm/errno.h
> > > > > > +++ b/arch/parisc/include/uapi/asm/errno.h
> > > > > > @@ -124,4 +124,6 @@
> > > > > >
> > > > > >  #define EHWPOISON    257     /* Memory page has hardware error=
 */
> > > > > >
> > > > > > +#define EFTYPE               258     /* Wrong file type for th=
e intended operation */
> > > > > > +
> > > > > >  #endif
> > > > > > diff --git a/arch/parisc/include/uapi/asm/fcntl.h b/arch/parisc=
/include/uapi/asm/fcntl.h
> > > > > > index 03dee816cb13..d46812f2f0f4 100644
> > > > > > --- a/arch/parisc/include/uapi/asm/fcntl.h
> > > > > > +++ b/arch/parisc/include/uapi/asm/fcntl.h
> > > > > > @@ -19,6 +19,7 @@
> > > > > >
> > > > > >  #define O_PATH               020000000
> > > > > >  #define __O_TMPFILE  040000000
> > > > > > +#define OPENAT2_REGULAR      0100000000
> > > > > >
> > > > > >  #define F_GETLK64    8
> > > > > >  #define F_SETLK64    9
> > > > > > diff --git a/arch/sparc/include/uapi/asm/errno.h b/arch/sparc/i=
nclude/uapi/asm/errno.h
> > > > > > index 4a41e7835fd5..71940ec9130b 100644
> > > > > > --- a/arch/sparc/include/uapi/asm/errno.h
> > > > > > +++ b/arch/sparc/include/uapi/asm/errno.h
> > > > > > @@ -117,4 +117,6 @@
> > > > > >
> > > > > >  #define EHWPOISON    135     /* Memory page has hardware error=
 */
> > > > > >
> > > > > > +#define EFTYPE               136     /* Wrong file type for th=
e intended operation */
> > > > > > +
> > > > > >  #endif
> > > > > > diff --git a/arch/sparc/include/uapi/asm/fcntl.h b/arch/sparc/i=
nclude/uapi/asm/fcntl.h
> > > > > > index 67dae75e5274..bb6e9fa94bc9 100644
> > > > > > --- a/arch/sparc/include/uapi/asm/fcntl.h
> > > > > > +++ b/arch/sparc/include/uapi/asm/fcntl.h
> > > > > > @@ -37,6 +37,7 @@
> > > > > >
> > > > > >  #define O_PATH               0x1000000
> > > > > >  #define __O_TMPFILE  0x2000000
> > > > > > +#define OPENAT2_REGULAR      0x4000000
> > > > > >
> > > > > >  #define F_GETOWN     5       /*  for sockets. */
> > > > > >  #define F_SETOWN     6       /*  for sockets. */
> > > > > > diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> > > > > > index 66bbf6d517a9..6d8d4c7765e6 100644
> > > > > > --- a/fs/ceph/file.c
> > > > > > +++ b/fs/ceph/file.c
> > > > > > @@ -977,6 +977,10 @@ int ceph_atomic_open(struct inode *dir, st=
ruct dentry *dentry,
> > > > > >                       ceph_init_inode_acls(newino, &as_ctx);
> > > > > >                       file->f_mode |=3D FMODE_CREATED;
> > > > > >               }
> > > > > > +             if ((flags & OPENAT2_REGULAR) && !d_is_reg(dentry=
)) {
> > > > > > +                     err =3D -EFTYPE;
> > > > > > +                     goto out_req;
> > > > > > +             }
> > > > >
> > > > > ^^^
> > > > > This doesn't look quite right. Here's a larger chunk of the code:
> > > > >
> > > > > -------------------------8<--------------------------
> > > > >         if (d_in_lookup(dentry)) {
> > > > >                 dn =3D ceph_finish_lookup(req, dentry, err);
> > > > >                 if (IS_ERR(dn))
> > > > >                         err =3D PTR_ERR(dn);
> > > > >         } else {
> > > > >                 /* we were given a hashed negative dentry */
> > > > >                 dn =3D NULL;
> > > > >         }
> > > > >         if (err)
> > > > >                 goto out_req;
> > > > >         if (dn || d_really_is_negative(dentry) || d_is_symlink(de=
ntry)) {
> > > > >                 /* make vfs retry on splice, ENOENT, or symlink *=
/
> > > > >                 doutc(cl, "finish_no_open on dn %p\n", dn);
> > > > >                 err =3D finish_no_open(file, dn);
> > > > >         } else {
> > > > >                 if (IS_ENCRYPTED(dir) &&
> > > > >                     !fscrypt_has_permitted_context(dir, d_inode(d=
entry))) {
> > > > >                         pr_warn_client(cl,
> > > > >                                 "Inconsistent encryption context =
(parent %llx:%llx child %llx:%llx)\n",
> > > > >                                 ceph_vinop(dir), ceph_vinop(d_ino=
de(dentry)));
> > > > >                         goto out_req;
> > > > >                 }
> > > > >
> > > > >                 doutc(cl, "finish_open on dn %p\n", dn);
> > > > >                 if (req->r_op =3D=3D CEPH_MDS_OP_CREATE && req->r=
_reply_info.has_create_ino) {
> > > > >                         struct inode *newino =3D d_inode(dentry);
> > > > >
> > > > >                         cache_file_layout(dir, newino);
> > > > >                         ceph_init_inode_acls(newino, &as_ctx);
> > > > >                         file->f_mode |=3D FMODE_CREATED;
> > > > >                 }
> > > > >                 err =3D finish_open(file, dentry, ceph_open);
> > > > >         }
> > > > > -------------------------8<--------------------------
> > > > >
> > > > > It looks like this won't handle it correctly if the pathwalk term=
inates
> > > > > on a symlink (re: d_is_symlink() case). You should either set up =
a test
> > > > > ceph cluster on your own, or reach out to the ceph community and =
ask
> > > > > them to test this.
> > > > >
> > > >
> > > > Thanks for reviewing. The d_is_symlink() case seems to be calling
> > > > finish_no_open so shouldn't this be okay?
> > > >
> > >
> > > My mistake -- you're correct. I keep forgetting that finish_no_open()
> > > will handle this case regardless of what else happens.
> > >
> > > > > >               err =3D finish_open(file, dentry, ceph_open);
> > > > > >       }
> > > > > >  out_req:
> > > > > > diff --git a/fs/fcntl.c b/fs/fcntl.c
> > > > > > index beab8080badf..240bb511557a 100644
> > > > > > --- a/fs/fcntl.c
> > > > > > +++ b/fs/fcntl.c
> > > > > > @@ -1169,9 +1169,9 @@ static int __init fcntl_init(void)
> > > > > >        * Exceptions: O_NONBLOCK is a two bit define on parisc; =
O_NDELAY
> > > > > >        * is defined as O_NONBLOCK on some platforms and not on =
others.
> > > > > >        */
> > > > > > -     BUILD_BUG_ON(20 - 1 /* for O_RDONLY being 0 */ !=3D
> > > > > > +     BUILD_BUG_ON(21 - 1 /* for O_RDONLY being 0 */ !=3D
> > > > > >               HWEIGHT32(
> > > > > > -                     (VALID_OPEN_FLAGS & ~(O_NONBLOCK | O_NDEL=
AY)) |
> > > > > > +                     (VALID_OPENAT2_FLAGS & ~(O_NONBLOCK | O_N=
DELAY)) |
> > > > > >                       __FMODE_EXEC));
> > > > > >
> > > > > >       fasync_cache =3D kmem_cache_create("fasync_cache",
> > > > > > diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
> > > > > > index 8344040ecaf7..4604e2e8a9cc 100644
> > > > > > --- a/fs/gfs2/inode.c
> > > > > > +++ b/fs/gfs2/inode.c
> > > > > > @@ -738,6 +738,12 @@ static int gfs2_create_inode(struct inode =
*dir, struct dentry *dentry,
> > > > > >       inode =3D gfs2_dir_search(dir, &dentry->d_name, !S_ISREG(=
mode) || excl);
> > > > > >       error =3D PTR_ERR(inode);
> > > > > >       if (!IS_ERR(inode)) {
> > > > > > +             if (file && (file->f_flags & OPENAT2_REGULAR) && =
!S_ISREG(inode->i_mode)) {
> > > > >
> > > > > Isn't OPENAT2_REGULAR getting masked off in ->f_flags now?
> > > > >
> > > > Yes, I thought the masking off was happening after this codepath go=
t
> > > > executed. Maybe it's better anyway to pass another flags param to t=
his
> > > > function and forward the flags from the gfs2_atomic_open function a=
nd
> > > > in other call sites pass 0 ? What do you think?
> > > >
> > >
> > > Also my mistake. That happens in do_dentry_open() which happens in
> > > finish_open(), so you should be OK here.
> > >
> > > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> >
> > Thanks for patiently reviewing this! I am planning on sending patches
> > for man-pages and looking into some xfs-tests for this. But I am not
> > sure if this patch series will get more reviews from others or if it
> > will be picked up in the vfs branch?
> >
>
> This is a change to rather core VFS infrastructure so yes, you should
> expect some more review. Assuming no major issues are found, then yes,
> this should eventually get picked up by the VFS maintainers.
>
> Cheers,
> --
> Jeff Layton <jlayton@kernel.org>

Ping....
This patch series got a "Reviewed-by" from Jeff Layton but it probably
requires more reviews from other maintainers/reviewers as well. So
requesting for review on this patch series. Thanks!

Regards,
Dorjoy

