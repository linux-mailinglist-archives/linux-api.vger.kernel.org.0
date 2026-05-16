Return-Path: <linux-api+bounces-6334-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGgoLiESCGqUXwMAu9opvQ
	(envelope-from <linux-api+bounces-6334-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Sat, 16 May 2026 08:43:45 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF6D55A818
	for <lists+linux-api@lfdr.de>; Sat, 16 May 2026 08:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C27E301411E
	for <lists+linux-api@lfdr.de>; Sat, 16 May 2026 06:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4049235B633;
	Sat, 16 May 2026 06:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lte6xRJp"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02942FFDF8
	for <linux-api@vger.kernel.org>; Sat, 16 May 2026 06:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778913821; cv=pass; b=HKzNRoQHH5pn9mXNQiaO6hFtpsgCTpLumqEsyvxeNPzxGdctUdAlog43RC+a6aXxWLJ9ZQr3/Nuc/5MDrv4sGSEDT2SjAgd4wB1ttaTuzdgtVXg1cY4M/10hXpi35af0fijUPAL/Aa6wlwEBiwArZCK5SOvXP2RnnQC/BiyGyFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778913821; c=relaxed/simple;
	bh=BOu7AkGfzBlU/bzal5lpBXqw/o4zx+y8OCCvr0FI1sY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z1arXFUwPUjb9kRyZYFqhLrYJcTkWqOjfPVXwVuJCHl/+dNSaVEzZ2EhinddvbJCt1QaFUbF9pjORyniIoC8sB3ZKNXeIffO+RmDQ2YaAavSSAbggS9nVyAuUUDDaCqOMvpP0tybf39tZK1XDXGmqNr6vPnqrXDEyLQRwKIQYIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lte6xRJp; arc=pass smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-47c6f914617so307766b6e.1
        for <linux-api@vger.kernel.org>; Fri, 15 May 2026 23:43:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778913819; cv=none;
        d=google.com; s=arc-20240605;
        b=K+tQ6qGbc+9bZQXuw8nOFdHBhMg22iwi3zZZU3zKlldVK4/iTpta6hysK/Ye3zNw2c
         q1+1uNeF6ZOLr8uA4CMhveQaAshX5YVVuUt1e1rFeUg91GC/D6uxPeRHpEADDdBXmR1H
         jcMroIF0Cz3cqnX7UIrubQjS9ue9c14POYk4bJC1vEj+3Smp1zHGhvIys4IFwBGY6+iX
         yQnJrlnX8OXn+1PjPA/uvfLl3jgqmD9oEwAGbW1NR2q8V8HUpFHG+Lv3LW2jIMmDplJF
         jkNb34a4gMcX0cW3GNeJfPhalq/MsuNmmgEG5qNMLXjVXnzH/h+ceMfryWYH6F+WDBqU
         6p2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9mxy2GpAHGinIR1PnXVMvug0ztGXvMspUp7huk1TMZs=;
        fh=aESv80qIMb+1uTsybhzn3Rn8bt5XpVgQlUxuWMNuNYA=;
        b=flZHsWYMPQkQUv5xyr6LRfQXMlAWPgamnVem8jwVIKCiT5RVQ0peRd6I6OasBCFYSC
         gIabczBlAUTq6eRX4gaf7zzIGZuetszlpm7bOXst4LQaWUokxPpj36jIcBPWB2MB7wKM
         8V/TD5n7IaeEeX/GmcR4hL7VM8qo5JerFG1Wuokjq/xmJP7S1nA4x9Qoi0fwwFoPCxV3
         1e6m1Re02Gr8oo+rlPTyTXZVtzyb/tamsiIVzBTkWb4YtD21S9XhAWo+9d6AfiZItXW8
         3Li2Hnok1Q7wFy+/xV2VOa8e59neA6ic3s45xGCfxvI7Rij9Y9fkm/IRDjEfS1i3czv2
         MFrw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778913819; x=1779518619; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9mxy2GpAHGinIR1PnXVMvug0ztGXvMspUp7huk1TMZs=;
        b=lte6xRJplRGmp/PSskcPRMRcmRHxp/3AN6A1XynLI6uXZlluhAn8u2h7mZQg7APZLK
         oAbu6jVFzk3P9a62b4PsoqoTNSJkE7FzjLFpOPv5Z+lsxgwuhtlVTrcbfv9MbnmVX5Py
         k/kzYjGMlhm8+gRGJfuzaDpFjgrS5WI83cFpH15WHsjn/iy/5C/Ve0iDz9Octg/QEDrA
         DhdqK6z9WrgQK213b5HL2plz3FNcI+orhuzLw1gTevyVgHFRj7CbGxDhPlje1LF0RZp7
         KU79gd97VCPt1LjtMq72jZt/AsJhd9asWIZ2PtbrgPLo+/sBoYkMDD8j7+KHYkro1zzO
         kN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778913819; x=1779518619;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9mxy2GpAHGinIR1PnXVMvug0ztGXvMspUp7huk1TMZs=;
        b=n0bFNgpzMWCr6etPRCmn2B2zCavKzvKsT+fzK4TxzK1QFHh2vy7VfpWS+3CvokFZ2R
         I8bjASVeeGsQQutGbW9S5yK8mtgxrzUSWJDVJjNb4Uvd1HUHXu3Mn+7gmfYEGhbIr2nH
         7l0UHho9SbWhPEprw4Rwuf3wOG27edm+ibayrEigsjLInkvREcSOAaqISPr5q8+vYjaB
         H7MdgeWXoTjkW7ZyNkClHCFdgCoUG2vtc2SyQtLBLUQN0a+SL/L4qu65YagR6fO7+e/z
         uf2Ic5JcKJWgw+BNipXP86VXLQ+Vruzbpirg5uEeJ9IpDDkWIYdERtRExBAgPOroVK38
         p3Bg==
X-Forwarded-Encrypted: i=1; AFNElJ976w8SPh/lujarg42ZNhVfMVu7EoGHmTB2p0rYgDQ3rek4aYHUyCoZSRfkLmoS4z7JynWnIBFHils=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0dusrD+00dfXKi0lFKqpLx4TW4s6lq8SOgnLDNE47d/WU+EVN
	+kZnhdWelqfj9yFgavUraG42bLr8sF8uX0ih8x76n9rTT/FSyeOyaS+3ZXBqwXfStAKEoWvfaEa
	ZDAHICBjg9YewIYhCSb4FIUmDUDOjLEs=
X-Gm-Gg: Acq92OE814MCmBNJRoTh218oZZmS9PS7qbqEcWqDwcWID5X574jRxajImpo1QTYrlcX
	dEUjn/CNkKZzBnkK8BXBllu/nQZcgyYhNRy8uTiRSCDKrI3iqiDuf/vLKNBaUfSQhdUje68I1HZ
	CtTJw+KvS51uef4QzNI7TmyiYvgC5dDEwJfgVPIO6+qnKiqsAia5cQCZESvN5lD72V1rGVZFydU
	pseuFjw6Vwg3XWwP1jv4VusOUkyuOchwk8XBzKGwTTJllVELSDBTaerfcCz1buekTlyDyi4tZA6
	vkW/xw/4vCHCFOJYmw==
X-Received: by 2002:a54:4e88:0:b0:46c:e542:cc3e with SMTP id
 5614622812f47-482e55e65a9mr3386045b6e.6.1778913818672; Fri, 15 May 2026
 23:43:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507-case-sensitivity-v14-0-e62cc8200435@oracle.com> <20260511-wertverlust-vorbringen-070f016f3bd4@brauner>
In-Reply-To: <20260511-wertverlust-vorbringen-070f016f3bd4@brauner>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Sat, 16 May 2026 08:43:00 +0200
X-Gm-Features: AVHnY4LulXSgBXmlt-XknhPT4FGQR5_lEWwUy9GN7jO6BYSv7kvOdT0vcpcWCyI
Message-ID: <CALXu0UdsurG-ayuYViqs0HXOfgyDw8gpNC+f=5y59cuuSPUbBA@mail.gmail.com>
Subject: Re: [PATCH v14 00/15] Exposing case folding behavior
To: Christian Brauner <brauner@kernel.org>, Chuck Lever <cel@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	hirofumi@mail.parknet.co.jp, linkinjeon@kernel.org, sj1557.seo@samsung.com, 
	yuezhang.mo@sony.com, almaz.alexandrovich@paragon-software.com, 
	slava@dubeyko.com, glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	tytso@mit.edu, adilger.kernel@dilger.ca, cem@kernel.org, sfrench@samba.org, 
	pc@manguebit.org, ronniesahlberg@gmail.com, sprasad@microsoft.com, 
	trondmy@kernel.org, anna@kernel.org, jaegeuk@kernel.org, chao@kernel.org, 
	hansg@kernel.org, senozhatsky@chromium.org, 
	"Darrick J. Wong" <djwong@kernel.org>, Roland Mainz <roland.mainz@nrubsig.org>, 
	Steve French <stfrench@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 1AF6D55A818
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6334-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,kernel.org,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,nrubsig.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cedricblancher@gmail.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Mon, 11 May 2026 at 16:11, Christian Brauner <brauner@kernel.org> wrote:
>
> On Thu, 07 May 2026 04:52:53 -0400, Chuck Lever wrote:
> > Christian, let's lock this one in. I will post subsequent changes
> > as delta patches.
> >
> > Following on from:
> >
> > https://lore.kernel.org/linux-nfs/20251021-zypressen-bazillus-545a44af57fd@brauner/T/#m0ba197d75b7921d994cf284f3cef3a62abb11aaa
> >
> > [...]
>
> Applied to the vfs-7.2.exportfs branch of the vfs/vfs.git tree.
> Patches in the vfs-7.2.exportfs branch should appear in linux-next soon.

@Chuck Lever Thank you!

Does that mean the support for case-insensitive filesystems will work
with Linux 7.2?

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

