Return-Path: <linux-api+bounces-5656-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D48FAD3B6D2
	for <lists+linux-api@lfdr.de>; Mon, 19 Jan 2026 20:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B815530C86D2
	for <lists+linux-api@lfdr.de>; Mon, 19 Jan 2026 19:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A653904FB;
	Mon, 19 Jan 2026 19:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="ZLCChveB"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184063904DB
	for <linux-api@vger.kernel.org>; Mon, 19 Jan 2026 19:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768849531; cv=pass; b=RHopWhL1H4wt9CFLUFUBpKwQ9H5ksgYqj2xFP0XPYA+i9f3Rt4ge54UYjWrx4h+5V2ef6wAsOsRGirEEQjJJEalkoxuyYE2aon0LdF39pW+qFPUhMhI0x1IUXmF6+3JmiP9kOqiSW96tkQAyKWOZzrSxJH9LVqr/lY3HQDFdNjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768849531; c=relaxed/simple;
	bh=/ce3dudxc2POARZLcfse5sBstVqNXvQFSe7cYp3NGco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BBJiKdqz8NZn8YXk6nxB1GdT1hBf+D53xC2RmD6NTrbUx4ZLVLO9CA63XN34VMob9X2un5X4I5fp/hL/cUNVjsjJPstaXVnU0S7oY82yysZbDstnIxz3GUcblX8GlRaccGUkerTC/KolKDs/3gvGnrn8TMjcXVCX6LZIfYtyp2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=ZLCChveB; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-59b7073f61dso5660679e87.2
        for <linux-api@vger.kernel.org>; Mon, 19 Jan 2026 11:05:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768849526; cv=none;
        d=google.com; s=arc-20240605;
        b=ar48OYxxZ3XCjN7Rlezr08Cp6xxK0FbBWTRl9OzGJ0HzQ7j+DhM0yq7iTNjcM43yhg
         Agd5cVF++u324vYV5SLMyiXMKJUCX+xSZBfXKIZgsNRk0TQf/nPlrSb7DAbAXLMOrJjj
         Q1B8sZ8cCETfaSqqAQVGTl8CdNCII67u+3b+md57rUqxtQckDPJ6a2BMWHfxvO0IAE/d
         mLuTMkiyH85y8UD8ZHm3SmQb3w/q1EeuzfumvO4oxjeD4uQ11A68niIbGTzhkIeM5cX2
         KKyGJ+Bfi7ewSxaI4EwnJ13980t1hDEilh5kItw0Lycj8UueEGssgHxs5RehzE+H2dpx
         v34Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uPgi7F8HbiHDXFnHy8+BFZNxNaHpq/Qib+SGUInhGco=;
        fh=Ts5oqKLjyBDsqMxZ0rFx3TUY2HohtAQoC8NNUM6W4v4=;
        b=l23WZtYvSAtQMBRPCy0W/9ZfWyIGxVVe9P8f172CbKg2raimSETaidmo0nR6kAowNf
         Hrwp1D2jyswRo1S9xufNbfFZGsJ5tIMAsa43NxKvqCxaBULNMm3Om22cjJX54WIKRd5Q
         NfgXEG3O8IC+5dL7hWYCgrNUaXKNJBgz7Knjz25dqa206586SHdXLvgSdQYbSpyGW06s
         Y5ja2ZOGmSQz90iI0CG/f4jxI2ebhSEVnv5LLgrz54xD5W0GhCDo3Goifx3pZeNYIJjT
         bmOvsa1gtN5n+gF21/TFzFDPsjn8h5XNNoWFli9bWm4XmbiuDkmw4MvA3xH2bkSiKRwq
         IfYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1768849526; x=1769454326; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uPgi7F8HbiHDXFnHy8+BFZNxNaHpq/Qib+SGUInhGco=;
        b=ZLCChveBpdWvmIIICTa6S/fc053UxqrmmgURpdZW4LIFa5kVxRtc9VCz7L9Hft9W42
         /XusbZMRQfSJ/+Zk3bm2qmindiU2KL9Vu5aPbKqode4lTBaRrDFuAlRnhroW+TlWqM1A
         w0/KsiQaEic9f+uvYLWwMN5rvaUDBEobMpjIQW6qfZGoxDEoDwJ76XMH5t4z2OLugh+p
         SMRz4F+sLSz51Mzt3h7BXK9cogEQyp9VwwFBdyUg9DnL1o7/Z5SUs+zwlghLOEv/Mhkb
         BqP7H7D4lAyKvP1aCfgWXICvg+iUaCT1iswB08UEggCCUa0XLsvLiMMjs5T/RH6SL7hC
         jsZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768849526; x=1769454326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uPgi7F8HbiHDXFnHy8+BFZNxNaHpq/Qib+SGUInhGco=;
        b=Y3/BF9dgi3goR/ehdqc6l+tO7DdMd+0q0+I/TIfRzVbe8uuocDHZNpdgjp6pKkU47T
         lnyIIs14MWN+PNMr4LKaCxu21wH0y+XEH0UzqaYKlfC3oCmsE0D5ysj8AO9qYWj0r+fL
         1QENAhDDagAc9oz3yxRXsQJBZSTnxdpKa2iNhqKIIoUx7F9savLebVNvI5UTdOH3wo0H
         RFbaWl37vrIJsYJ2cfWf6cFJvuIOeFDuCanN2DTWSOWXSLOeP1AD0wcYOX3wCuhrEyeZ
         /sR9EeOh2ZIj00mZRJZRUyqoytyRyFaj/H4Eq/8EgJAIWWjrEqLyRZzXJ5uxTOB3T/5z
         PxCA==
X-Forwarded-Encrypted: i=1; AJvYcCVN7jSGsRFCkcfGfM39hgtSR6DewvrwIrizNo/RV3Fzss4EAyLy42f1Dz2PrEGLvKxTYvC/16/Xm3M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4/5XGlZiMKj01lK5ymiFvqEH9P7JMzCgt2Amigv2yTvu2JtQX
	aaOkf3LL8vKu5caqUadHfYHkLVWOb3dvGiSq6HI1q69WDzIPhSdQvdiultbUKjalfIl/Y05wzMH
	iA+Eq4t6fS6n40flD2+WoaZKxiLBV2fqlcNOk/fYo
X-Gm-Gg: AY/fxX7p6cb9VjJByIBPwI1vVgZZK6fbf1qkH9YrJrI7cqXlmMRNCO2ByUCQJvqbkuO
	VMGMEytuRXdduZqKhNfTvKSxiIKoWE2QwYGeY/0IckzV4acwm1z0Y4hFrhPmVx8Ig2aHafwPoG6
	pZxadAPhrMKcQltv9vhbw7veaKjGUOLFkff0LAMitobm4IWHNYUFYnQRiT5Pukg+cUmsEWihfIU
	qJqljGNXKyZaB4ty6Y8jfMf4Cw6mHHDqOh+4C7ICfSfjeCKfrXUT0qhtfafGXjSKeQh
X-Received: by 2002:a05:6512:3c95:b0:599:289c:67b with SMTP id
 2adb3069b0e04-59baeeadbc3mr4115534e87.21.1768849526113; Mon, 19 Jan 2026
 11:05:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251229-work-empty-namespace-v1-0-bfb24c7b061f@kernel.org> <20260119171101.3215697-1-safinaskar@gmail.com>
In-Reply-To: <20260119171101.3215697-1-safinaskar@gmail.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Mon, 19 Jan 2026 11:05:14 -0800
X-Gm-Features: AZwV_Qi9RyaiB91QL-WyEcAJf4X_KdMWwLXZLw6yqaw5pxCOP4suRdhto2Jp-kE
Message-ID: <CALCETrWs59ss3ZMdTH54p3=E_jiYXq2SWV1fmm+HSvZ1pnBiJw@mail.gmail.com>
Subject: Re: [PATCH 0/2] mount: add OPEN_TREE_NAMESPACE
To: Askar Safin <safinaskar@gmail.com>
Cc: brauner@kernel.org, amir73il@gmail.com, cyphar@cyphar.com, jack@suse.cz, 
	jlayton@kernel.org, josef@toxicpanda.com, linux-fsdevel@vger.kernel.org, 
	viro@zeniv.linux.org.uk, Lennart Poettering <mzxreary@0pointer.de>, 
	David Howells <dhowells@redhat.com>, Zhang Yunkai <zhang.yunkai@zte.com.cn>, cgel.zte@gmail.com, 
	Menglong Dong <menglong8.dong@gmail.com>, linux-kernel@vger.kernel.org, 
	initramfs@vger.kernel.org, containers@lists.linux.dev, 
	linux-api@vger.kernel.org, news@phoronix.com, lwn@lwn.net, 
	Jonathan Corbet <corbet@lwn.net>, Rob Landley <rob@landley.net>, emily@redcoat.dev, 
	Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 10:56=E2=80=AFAM Askar Safin <safinaskar@gmail.com>=
 wrote:
>
> Christian Brauner <brauner@kernel.org>:
> > Extend open_tree() with a new OPEN_TREE_NAMESPACE flag. Similar to
> > OPEN_TREE_CLONE only the indicated mount tree is copied. Instead of
> > returning a file descriptor referring to that mount tree
> > OPEN_TREE_NAMESPACE will cause open_tree() to return a file descriptor
> > to a new mount namespace. In that new mount namespace the copied mount
> > tree has been mounted on top of a copy of the real rootfs.
>
> I want to point at security benefits of this.
>
> [[ TL;DR: [1] and [2] are very big changes to how mount namespaces work.
> I like them, and I think they should get wider exposure. ]]
>
> If this patchset ([1]) and [2] both land (they are both in "next" now and
> likely will be submitted to mainline soon) and "nullfs_rootfs" is passed =
on
> command line, then mount namespace created by open_tree(OPEN_TREE_NAMESPA=
CE) will
> usually contain exactly 2 mounts: nullfs and whatever was passed to
> open_tree(OPEN_TREE_NAMESPACE).
>
> This means that even if attacker somehow is able to unmount its root and
> get access to underlying mounts, then the only underlying thing they will
> get is nullfs.
>
> Also this means that other mounts are not only hidden in new namespace, t=
hey
> are fully absent. This prevents attacks discussed here: [3], [4].
>
> Also this means that (assuming we have both [1] and [2] and "nullfs_rootf=
s"
> is passed), there is no anymore hidden writable mount shared by all conta=
iners,
> potentially available to attackers. This is concern raised in [5]:
>
> > You want rootfs to be a NULLFS instead of ramfs. You don't seem to want=
 it to
> > actually _be_ a filesystem. Even with your "fix", containers could comm=
unicate
> > with each _other_ through it if it becomes accessible. If a container c=
an get
> > access to an empty initramfs and write into it, it can ask/answer the q=
uestion
> > "Are there any other containers on this machine running stux24" and the=
n coordinate.

I think this new OPEN_TREE_NAMESPACE is nifty, but I don't think the
path that gives it sensible behavior should be conditional like this.
Either make it *always* mount on top of nullfs (regardless of boot
options) or find some way to have it actually be the root.  I assume
the latter is challenging for some reason.

--Andy

