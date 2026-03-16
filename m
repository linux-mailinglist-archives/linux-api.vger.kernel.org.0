Return-Path: <linux-api+bounces-5994-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCfvElgsuGnhZgEAu9opvQ
	(envelope-from <linux-api+bounces-5994-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 16 Mar 2026 17:14:16 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC5E29D241
	for <lists+linux-api@lfdr.de>; Mon, 16 Mar 2026 17:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 053AB3070AFA
	for <lists+linux-api@lfdr.de>; Mon, 16 Mar 2026 16:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A48332610;
	Mon, 16 Mar 2026 16:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j44JMaNr"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDA7332604
	for <linux-api@vger.kernel.org>; Mon, 16 Mar 2026 16:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773677572; cv=pass; b=lKyiSK0+g+nHo6OMoSNdNXgfZk1EubA10AxmQYcEVlVQvObqnLEHvK5FDYWZh4rVlgnbpDNVvfDeciNabDv/UAUmnf443Gj7oGpC0myQdxRVEG0NfJiKju2LUsgWZlh65Ay2sLOhRE/td2/+4wjSPkRbEbK9TWx8vLObhgvWahY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773677572; c=relaxed/simple;
	bh=mngjUXyQIGRdPpzvMVY93piHPQBoPK11l7fLKRKjC7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qtNZY2v+9ml9dGnt/J98yKRlEwqCFmC1soAaX35FBGlOzFCXpov85rWI1DQ2sFhm4qKmRbxn0m7xhY1c04OnzeTnFoMBy4rkarxUJW/tzzh8NTcJ1Al9MkVURX5elfjt3Ra/EMJe39Y465ZzgIEihBxSBR5DtOyDtYaMevtW2E4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j44JMaNr; arc=pass smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-5ffe1c7337eso1048133137.2
        for <linux-api@vger.kernel.org>; Mon, 16 Mar 2026 09:12:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773677570; cv=none;
        d=google.com; s=arc-20240605;
        b=Qgxt16O08jEdNP2PL+zT8hTLFk6DnX0ye0TQVZM48TBHI3zf/GnPHE89yfcGyZuxPs
         GjdwoYcGfdOk9bgoc95+RUpx67sHVHIGlkexZYSqz3e+smsVMS+si49Qu2AM5HDfsHuX
         9YG/dyVM1djmoDoCd6DwklJqsyIJcTxrTEkOu0xx8i/tdijMjQItb7CwRiPS6EvPDTlm
         P2zRLRbjV2HfCv19z7ryrR9cFIl53TgnCCHZPRoGOdQqG2ZJMIo9QHIdQcyfhCtGllAk
         rX9z1eXAkNO3F2umaHP5IJGXrPn+bNn5vS8VIyoPkXf9DCb/FWkGqYYaZJl7jQ+F75+Q
         HSPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J1pru+Gdj6fAyFCvZjE2fE08MsUs87siGvVmJJo9pqs=;
        fh=/CSgmO1beuJKk4EW05dxGxOWby5kjIzMG+E227QBz1I=;
        b=hDGLzrxqrb+mb6aPG5LzQ3OBm7Lck8nHfPrPThaoNsq2lLlOBtDWBE/3C6B99xHn4N
         ih5yoW0aI58sf9fqt34SED80qQR4CO9yt+U2cL7sVvgIz1f0MlU/qRfRfb43W/XxsSE8
         Mt9cTM08kY5LUh3sa9nd0KJviQluhlFyQt1Jnh6ODTfBQgdFPo988TG8vGzwCMs7RIVf
         NlPxrVSAeUStkBobs3qx/ZlwKSHle44VZIMSPVZU1CVfznMvg9YGd1Mbajzj4g2M+Nly
         wn9u16WdHbQcFqAPyMoxmozdLGzyEIPpol45ZaPkaw/iQwXC0mkgzgneeTskn/jA7oQx
         rNjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773677570; x=1774282370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J1pru+Gdj6fAyFCvZjE2fE08MsUs87siGvVmJJo9pqs=;
        b=j44JMaNrFBAXhZkUUvHY/tt1leg33h3rAo3Ugh3BKflwB6ZUzBgJTvqJM5+uLK+FZI
         7vHgnOIh005vRT1XNeK/P28EbrLwAY/wN+E+a1YpUsrgtcArcEtuNr0CPqNh5BysxXra
         a1BHvzFzgS8inLM8Q756Pdnf/ddDwQ2KtDCmWdoKhl9nzPbZ/02QEnbg2oOhAd+Y8f2+
         Gwir3ZTttiZa04Dp0+sfXei0I5H6h548/Nk8m3hrRxqGTwtVSaWVo98q9kies8dh9PG0
         VGYddRJgagKEk5WsBQZj7dJEx4hbG6Svn6nf3WPOYIFjG5q1dQWstWlCGXxL7pby2XZO
         8XeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773677570; x=1774282370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J1pru+Gdj6fAyFCvZjE2fE08MsUs87siGvVmJJo9pqs=;
        b=gE6ge9dQU/Hc57aJIitc6RXDLZ/1MlW9NWGQmhNDuegNPi1S/qLP/ebdbV8bHGBbfn
         Vm6jFiPI/h8mMwmJR0z6DNef9J0zmMTVzPZOhuPbWY3nAMA/GSOX6vO0tbrJT82LEzY7
         hbh50jINq7rU0fYcWsm7ue3mEC1R9Xy5Tvs3MoMAcF2mAJZM9PpeRCzhaIym2AFSV/DK
         igmPBUOUXhP4kKrEOM2wlEIAg6KTnVB6k42AXDUvW7rQYTqjMzUxBWRBTKogzGiabDox
         rrVAmjyE0O4xdhnEF/8zkOYu3hmoUFNRuVFf95o3lBqK2FJP4DEgSZwERZqAiR95nk7f
         yr/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXC9cwmYF0VFqlk6ebf1eIVbyrjfmhEQQyL7aivSNJ2K2EZwRX/Gpz9XAn9Sq/raGIaR5L0n+b2WSw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1Ee2NiGgIkRfBrBWtvX3HtiV17cxE5mlYrqxb8GIoSOp+21qf
	CKDN0xCkQI0icBjfkqqWDt7j+L+GeSmwUHXYfNmrhsNAeOJw4jkBS9pD0iPU/bXDKb5q4dXsCGl
	VHQiF4phNyG1pnO3zmeJfWSITCTpxY7E=
X-Gm-Gg: ATEYQzwSB+pP8XzLGclIcNN6zOwBo8Vx0sGT6FsELN2ibywtcY+h57h48BIu0cgWTIb
	ZEY+eYOQatm5Hk5AO7e7FfS4axYyZPzeXlRmv206UNidpDBzx6YSymveyacdzEnPwPpAtFMgjfm
	uiw/5iVhOGBSDtaM5iQqGyXMYeFTX018uuKL15suxKrndEw+4cSExVL2uLkgdzNT5idGqWBLpyj
	C1Z8R/jqVDtAiLuVk4F4/uruRAAKFMyikQkd74XAmkla87ayM3cF0pKdYmOSMxq4aB2/qQDEc2m
	Pj21GzixK0EveVrN+oWduM9PRuyh/C5dPusmYjYb1l51
X-Received: by 2002:a05:6102:b0f:b0:5ff:fbe4:8a7 with SMTP id
 ada2fe7eead31-6020e52bc2cmr4525326137.24.1773677569597; Mon, 16 Mar 2026
 09:12:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307140726.70219-1-dorjoychy111@gmail.com>
In-Reply-To: <20260307140726.70219-1-dorjoychy111@gmail.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Mon, 16 Mar 2026 22:12:38 +0600
X-Gm-Features: AaiRm53PnIFKVZg8YyfIZR4HMQW1Q6cca8fQLreG4GsNHelMK8lmfHxNIAUkk-o
Message-ID: <CAFfO_h6iNKbcKUi+Em2emRvXdZCfxcm7HnCenpTg9pSsHMb6YA@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] OPENAT2_REGULAR flag support for openat2
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, jlayton@kernel.org, chuck.lever@oracle.com, 
	alex.aring@gmail.com, arnd@arndb.de, adilger@dilger.ca, mjguzik@gmail.com, 
	smfrench@gmail.com, richard.henderson@linaro.org, mattst88@gmail.com, 
	linmag7@gmail.com, tsbogend@alpha.franken.de, 
	James.Bottomley@hansenpartnership.com, deller@gmx.de, davem@davemloft.net, 
	andreas@gaisler.com, idryomov@gmail.com, amarkuze@redhat.com, 
	slava@dubeyko.com, agruenba@redhat.com, trondmy@kernel.org, anna@kernel.org, 
	sfrench@samba.org, pc@manguebit.org, ronniesahlberg@gmail.com, 
	sprasad@microsoft.com, tom@talpey.com, bharathsm@microsoft.com, 
	shuah@kernel.org, miklos@szeredi.hu, hansg@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,arndb.de,dilger.ca,linaro.org,alpha.franken.de,hansenpartnership.com,gmx.de,davemloft.net,gaisler.com,redhat.com,dubeyko.com,samba.org,manguebit.org,microsoft.com,talpey.com,szeredi.hu];
	TAGGED_FROM(0.00)[bounces-5994-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[42];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dorjoychy111@gmail.com,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-api];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: EAC5E29D241
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Ping...
Requesting for review on this patch series please.

Regards,
Dorjoy


On Sat, Mar 7, 2026 at 8:07=E2=80=AFPM Dorjoy Chowdhury <dorjoychy111@gmail=
.com> wrote:
>
> Hi,
>
> I came upon this "Ability to only open regular files" uapi feature sugges=
tion
> from https://uapi-group.org/kernel-features/#ability-to-only-open-regular=
-files
> and thought it would be something I could do as a first patch and get to
> know the kernel code a bit better.
>
> The following filesystems have been tested by building and booting the ke=
rnel
> x86 bzImage in a Fedora 43 VM in QEMU. I have tested with OPENAT2_REGULAR=
 that
> regular files can be successfully opened and non-regular files (directory=
, fifo etc)
> return -EFTYPE.
> - btrfs
> - NFS (loopback)
> - SMB (loopback)
>
> Changes in v5:
> - EFTYPE is already used in BSDs mentioned in commit message
> - consistently return -EFTYPE in all filesystems
>
> Changes in v4:
> - changed O_REGULAR to OPENAT2_REGULAR
> - OPENAT2_REGULAR does not affect O_PATH
> - atomic_open codepaths updated to work properly for OPENAT2_REGULAR
> - commit message includes the uapi-group URL
> - v3 is at: https://lore.kernel.org/linux-fsdevel/20260127180109.66691-1-=
dorjoychy111@gmail.com/T/
>
> Changes in v3:
> - included motivation about O_REGULAR flag in commit message e.g., progra=
ms not wanting to be tricked into opening device nodes
> - fixed commit message wrongly referencing ENOTREGULAR instead of ENOTREG
> - fixed the O_REGULAR flag in arch/parisc/include/uapi/asm/fcntl.h from 0=
60000000 to 0100000000
> - added 2 commits converting arch/{mips,sparc}/include/uapi/asm/fcntl.h O=
_* macros from hex to octal
> - v2 is at: https://lore.kernel.org/linux-fsdevel/20260126154156.55723-1-=
dorjoychy111@gmail.com/T/
>
> Changes in v2:
> - rename ENOTREGULAR to ENOTREG
> - define ENOTREG in uapi/asm-generic/errno.h (instead of errno-base.h) an=
d in arch/*/include/uapi/asm/errno.h files
> - override O_REGULAR in arch/{alpha,sparc,parisc}/include/uapi/asm/fcntl.=
h due to clash with include/uapi/asm-generic/fcntl.h
> - I have kept the kselftest but now that O_REGULAR and ENOTREG can have d=
ifferent value on different architectures I am not sure if it's right
> - v1 is at: https://lore.kernel.org/linux-fsdevel/20260125141518.59493-1-=
dorjoychy111@gmail.com/T/
>
> Thanks.
>
> Regards,
> Dorjoy
>
> Dorjoy Chowdhury (4):
>   openat2: new OPENAT2_REGULAR flag support
>   kselftest/openat2: test for OPENAT2_REGULAR flag
>   sparc/fcntl.h: convert O_* flag macros from hex to octal
>   mips/fcntl.h: convert O_* flag macros from hex to octal
>
>  arch/alpha/include/uapi/asm/errno.h           |  2 +
>  arch/alpha/include/uapi/asm/fcntl.h           |  1 +
>  arch/mips/include/uapi/asm/errno.h            |  2 +
>  arch/mips/include/uapi/asm/fcntl.h            | 22 +++++------
>  arch/parisc/include/uapi/asm/errno.h          |  2 +
>  arch/parisc/include/uapi/asm/fcntl.h          |  1 +
>  arch/sparc/include/uapi/asm/errno.h           |  2 +
>  arch/sparc/include/uapi/asm/fcntl.h           | 35 +++++++++---------
>  fs/ceph/file.c                                |  4 ++
>  fs/gfs2/inode.c                               |  6 +++
>  fs/namei.c                                    |  4 ++
>  fs/nfs/dir.c                                  |  4 ++
>  fs/open.c                                     |  4 +-
>  fs/smb/client/dir.c                           | 14 ++++++-
>  include/linux/fcntl.h                         |  2 +
>  include/uapi/asm-generic/errno.h              |  2 +
>  include/uapi/asm-generic/fcntl.h              |  4 ++
>  tools/arch/alpha/include/uapi/asm/errno.h     |  2 +
>  tools/arch/mips/include/uapi/asm/errno.h      |  2 +
>  tools/arch/parisc/include/uapi/asm/errno.h    |  2 +
>  tools/arch/sparc/include/uapi/asm/errno.h     |  2 +
>  tools/include/uapi/asm-generic/errno.h        |  2 +
>  .../testing/selftests/openat2/openat2_test.c  | 37 ++++++++++++++++++-
>  23 files changed, 127 insertions(+), 31 deletions(-)
>
> --
> 2.53.0
>

