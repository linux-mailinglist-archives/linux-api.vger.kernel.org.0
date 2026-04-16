Return-Path: <linux-api+bounces-6105-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NBMJFL/4GkSoQAAu9opvQ
	(envelope-from <linux-api+bounces-6105-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 16 Apr 2026 17:25:06 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09792410AF2
	for <lists+linux-api@lfdr.de>; Thu, 16 Apr 2026 17:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E96DA30104A8
	for <lists+linux-api@lfdr.de>; Thu, 16 Apr 2026 15:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B88F3E3C42;
	Thu, 16 Apr 2026 15:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4lVbpH3"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597293E1CFA
	for <linux-api@vger.kernel.org>; Thu, 16 Apr 2026 15:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776352939; cv=pass; b=Ha/XTMRLZPf+KUVBifT3sjJ2678hqA0xi3b/f3mfuYx8LEZPMRDRH51XpHwIEPLAyNcuyabfJGdAMPZc5LiTJN3RvXei8/YcQ05DfPMzlkeZxk8jnwpOlBoGgLJ/4xSv40SYbohNiK2fSZwf9C8zHUkIFv3MZD/DQL8lHh02ZvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776352939; c=relaxed/simple;
	bh=d8h0wpCxAz5qr8QgJAWyo5NPmRw20h5MEF24J15IyVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nppMNHPk41dyNGTamniaRxswWpT3KVxfcSmXFTSdUwotd7nlusiDB10NsgXwwVbsMvCD5lDVN9QaynCoZATJfPlIKxzBAPfHuSA6HI6mi0icejiW0y5YrSycTayXVdMTecllR6Heuba+ZPtmkSh4QDrEpocbtOohnaApVRVIQ10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g4lVbpH3; arc=pass smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-956995b5bb6so1395425241.3
        for <linux-api@vger.kernel.org>; Thu, 16 Apr 2026 08:22:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776352935; cv=none;
        d=google.com; s=arc-20240605;
        b=fmiOgC3Fe73rmgT79fvZLZoQrRKbAJq/oKm3x4Ly3+eyZALJLUM/kCFdbzfiYj6AYF
         TalwQko59ZO070tsh+WyG5//5ZPbDLYHTaNkLI/jSAsHc8gnN1ECibEBGhxg7Wre01Jc
         m3CcOr7QGkLJsQkPwu+VXWlRJC4KQk4gUFvcMOEM4FsjOVdHPqdDlS/twNy0wTk8X5b0
         0PdzQoF+AJs3hxm9tKSy50A4J0tbhY4bJvN6CC0WUCy9pMXsuYO6rRVVLzj1B1SRitxc
         CTwju7FxSR2uyVxSR8BAh8YbPs5JL0Gj8JnEBAkADP7eybRNW3kGnTQt01EQevXvaEhN
         I2BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZrzbbPcScOB3YiJODipm6pYCq1GabErqB6lK+E1UuOI=;
        fh=BdRZrzV6klEgx5QMgSRFiJJdMlWjTaionfgBzfn1Tlg=;
        b=SWqHtL36rdhmUcwcLcATLoMkkt2v1BO2uiVj4bccxlKOBjdRU5r1vQ/xiiEPRIZJeP
         9HQ6YmNyl0g8ugRIJpzQ9/tpd2TtGH9FI/ajaplBR9XMuYpSsz2IAwiMHlnsflLoPdzz
         1t7QpamAaIpVS4qHLTMs4DL6o69SL51KV0D/l/fDduNc7PZuCAe94dUmR+UHgIs5RcnP
         aVmRiEaJUwMfo3oChNJlx/od3jnYmwXEQRiL+wSpI933a43fWyou/R+gqMTr3jnmxPN+
         HQJX+ZAzPNSXlkJwT2IV1a0dvVqLbOKpcOPyAdlITC5QlK6XwgqEu4NRiELO2ZzXGn2R
         0iTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776352935; x=1776957735; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZrzbbPcScOB3YiJODipm6pYCq1GabErqB6lK+E1UuOI=;
        b=g4lVbpH3NYuTwHK4zof4cI1R5F3IIOc7rqMOk/MWHpRmevLzRVb+qRlTlkjItjBIHx
         c7M0jhqWfaQ2vMdmdCGZvAPwF+odTZ9kyd6p7sv+kuJPT06vFRz8sGzxEE+RDZyrNUPi
         T43wkAslMCjJ0svGA08kUb5Gbx/3985K1GhQDZgh/+pTKuxWXmHDa0LxQ7N8Y6D+AdMV
         pK9JcsBfafPuXYE4xQ1M0Bsj7zmPTRKj8Oqs1QY2itp7CaL3brWr7nECH3oyQEx2Fb50
         mvvGzjXFjjCeXabKEm078u3WnFCD8fkfLKek/kSJSKQGUKyNJa4mEQC63tdpwccNytZ5
         6URQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776352935; x=1776957735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZrzbbPcScOB3YiJODipm6pYCq1GabErqB6lK+E1UuOI=;
        b=E8n0b4CFinkyl5oJYSzMO7BflDJA9PiLgfPBstqAK3Iwr5sEWYxewuGWE6GiDdXk4f
         PYc2qTeewaLCJZKBkotAHCcrY7CZxKs6mrph+BoicwYNaEcQVvcQk0zZjqwJLkQtMR6c
         gGmSR2COxvvU/8wcCFlqbkRbCE5MV3FGy/YkLPX8ezM97ARDK5SJJtSzKUibQmtixgB+
         CxeSCyGE6TgM46ru3Z07cp6/fmfsw7Dl+SrlfdryrgfQ9MRMeDsvL3nO1mUbD30CXnPr
         JyoVdvAgm84acVebn60r11gyFA0fQmcpX4/SMW0wGoUqF2fdSmYLzLPu3cYYCzIuvtFZ
         NBUQ==
X-Forwarded-Encrypted: i=1; AFNElJ8e7/3WwxxRJuWWT0nMEFWbrWuqW7+hI9QthKRk3DJsGL0alp0EPjXeAU0BG2Kdi2+t4kx0B9kdIp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdYEH6ybhJ1Egxr2A3DkFrGudqMs5v/2z+7Bo5z+ulPh/jt7sV
	IZ2Xu21dFbr6W7D34HRLNgXBGMimUFgRfFnykmZytIwCHAcHBRwQ56dl1o8gMJNaTQRzWsR/Rdw
	2owXJTf31Rawfz/nKs4PxFcpAssTZ2yE=
X-Gm-Gg: AeBDievE/j+dRA7irU1xORriGmgddgn127g6q4B3Ld/6F7w/Gd6DX6mvdzXt/aMeoCT
	ZX/E1ee9G0hjIkgN+6/jag97EVZzNBO1+ut5BTeH88Yxg+yIob7zliQRq8n/F0vFICs6JFzu9cx
	o8SLVlEvYHKWJ69tkhSpI9xPoyH1wF56F7AKj44JhUHj2nE4+OC46CGpxoC+MpNsOEd14CihJDU
	QdzzVkkQMNnRd9Um+B4eUtysPHjES4s+YxcleSa21uHTIDDhZx5WoHWVdJ1tf5gRnaoxYx3wNNZ
	yjpqsA40NhYxWqQRes9157vAryJgmYW8fnttfbjCLw==
X-Received: by 2002:a05:6102:4194:b0:610:48e8:8c4a with SMTP id
 ada2fe7eead31-61048e896d0mr7561251137.24.1776352934841; Thu, 16 Apr 2026
 08:22:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260328172314.45807-1-dorjoychy111@gmail.com> <20260416-abgraben-seeweg-a44ce660957f@brauner>
In-Reply-To: <20260416-abgraben-seeweg-a44ce660957f@brauner>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Thu, 16 Apr 2026 21:22:03 +0600
X-Gm-Features: AQROBzDwlhonUu0OdB2GZDkt71Qp2GPutRABZHn8dYTEqH0ntcAPsZO_it5641c
Message-ID: <CAFfO_h5mORm0OuK-d4thzBWWySmyvLSVeVa7phZc4Df-8D=1Cg@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] OPENAT2_REGULAR flag support for openat2
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	jlayton@kernel.org, chuck.lever@oracle.com, alex.aring@gmail.com, 
	arnd@arndb.de, adilger@dilger.ca, mjguzik@gmail.com, smfrench@gmail.com, 
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
	TAGGED_FROM(0.00)[bounces-6105-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[42];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,zeniv.linux.org.uk,suse.cz,kernel.org,oracle.com,gmail.com,arndb.de,dilger.ca,linaro.org,alpha.franken.de,hansenpartnership.com,gmx.de,davemloft.net,gaisler.com,redhat.com,dubeyko.com,samba.org,manguebit.org,microsoft.com,talpey.com,szeredi.hu];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dorjoychy111@gmail.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 09792410AF2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 16, 2026 at 7:07=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Sat, 28 Mar 2026 23:22:21 +0600, Dorjoy Chowdhury wrote:
> > I came upon this "Ability to only open regular files" uapi feature sugg=
estion
> > from https://uapi-group.org/kernel-features/#ability-to-only-open-regul=
ar-files
> > and thought it would be something I could do as a first patch and get t=
o
> > know the kernel code a bit better.
> >
> > The following filesystems have been tested by building and booting the =
kernel
> > x86 bzImage in a Fedora 43 VM in QEMU. I have tested with OPENAT2_REGUL=
AR that
> > regular files can be successfully opened and non-regular files (directo=
ry, fifo etc)
> > return -EFTYPE.
> > - btrfs
> > - NFS (loopback)
> > - SMB (loopback)
> >
> > [...]
>
> - I've added an explanation why OPENAT2_REGULAR is only needed for some
>   ->atomic_open() implementers but not others. What I don't like is that
>   we need all that custom handling in there but it's managable.
>
> - I dropped the topmost style conversions. They really don't belong
>   there and if we switch to something better we should use (1 << <nr>).
>
> - I split the EFTYPE errno introduction into a separate patch.
>
> ---

Thanks for fixing up and picking this one up!

>
> Applied to the vfs-7.2.openat.regular branch of the vfs/vfs.git tree.
> Patches in the vfs-7.2.openat.regular branch should appear in linux-next =
soon.
>

I don't see a vfs-7.2.openat.regular branch in vfs/vfs.git tree in
git.kernel.org.  Maybe this hasn't been pushed yet?

> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
>
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
>
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: master
>

I guess you wanted to mean vfs-7.2.openat.regular here?

Regards,
Dorjoy

