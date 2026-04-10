Return-Path: <linux-api+bounces-6079-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id teAUIVz02GmskAgAu9opvQ
	(envelope-from <linux-api+bounces-6079-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 10 Apr 2026 15:00:12 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1E03D7CE7
	for <lists+linux-api@lfdr.de>; Fri, 10 Apr 2026 15:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EADE1301F266
	for <lists+linux-api@lfdr.de>; Fri, 10 Apr 2026 12:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021FD191F98;
	Fri, 10 Apr 2026 12:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LurBBRc0"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BF71509AB
	for <linux-api@vger.kernel.org>; Fri, 10 Apr 2026 12:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775824564; cv=pass; b=pUBUm+tEVltMK8ftHGYS79QC4dhHM6+ej4IbiOn7GNjzez80bJZJCTYuz6vIetDnXvOdnXiJWg5yV/8Isdz0s+RNUvQmmkhIEDgEgwCrpzgD0Nk5c8J7NP8pO/LlzJHY1aGEaKKbM3EmZMN41oaGC7pf5cgmjUdA3jIycorTqKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775824564; c=relaxed/simple;
	bh=Ewiqt27VmQgPelzQrIPxh4/qEBWrEg/9WiLDKDX0Ycw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oZxNMP/3becU6btPP5PB5Q1qcg1xsI7+gWZ7LNJNXDeYHdO4jmg5+LvWBye0ooWkoHQGMRr2dM+5Wixo+wYseOEaAR5ms7Z75LkakTYDZNmz2zuDjBS6YRESbln61w50UBaa47XLbttK+9m/sB+7X/lrdv0y4pngBj7VWjCH+rY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LurBBRc0; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a3d1561e38so1621424e87.0
        for <linux-api@vger.kernel.org>; Fri, 10 Apr 2026 05:36:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775824561; cv=none;
        d=google.com; s=arc-20240605;
        b=j0Fqa2ao8vCYi3UhY6o5Pfz0hjUnn3AvDbWnufUYTzsh9gPAOp061uyuQvukQT7fr0
         mz23dy4WCNMvd1+bSPuKZuJL7+ENSmKrov2XONz7jPfjqmXTR68v/A4xDYNuwKtva9zE
         rJBefsFVqWLi2GYHW9YyWEmTmT1Bidokm6uTeI7qOHXnwWfM7rCmhjBJzYa5nrVV3LY7
         g50cb4z7cyAN/3FvPqiy+FnoTXWA65iSvRpNq3tRP0OYAA7I6T7VCdbgdj6eanVv7+f1
         4PqpU8BineZhwmNjJa/rbcDRYBOiq4Qt3pktEEjoTN+oJxhxFOSp4oLcADmggXoQLRsB
         3xjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=g5J4QxMaotyWS841K4tfeJFjDiBCE/6Zj3Tj9mZiSxY=;
        fh=Yev4Q4tyJN2Z57R/NrjipwIlSmBDg3Ei7wKj0edc1Kk=;
        b=ToQcm8lw4hpjOJfmsWi82kR8wdZp7V15Odn24JAh/tPWQ8Upo9WiL+lN6tdDU7bTrl
         A9Qomly55PqHRCdOJFaFnaDHpDpGwRN/KOzApp8DJPllzctOeOsbR4YN54SFztZEUwdF
         k4E4jaejfPMLx6Xy0N9+cvgQF2PL+TXeqMMSsTEX9xQhGp621syjernJZdGMYBySl/X4
         NfAElM8hrcGTdtzWEIURqAABtfGeiWRivnPa99A0rEuIfL0S1wmkOAqtiiCfTWuYBFKN
         jRW0rx+1PgYZlnehb/5bCT+NVry/TflvJTflKh8Mxdq7m/kpEcWbyyi3Qq1inAPljGI1
         jpyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775824561; x=1776429361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g5J4QxMaotyWS841K4tfeJFjDiBCE/6Zj3Tj9mZiSxY=;
        b=LurBBRc0xarrG0ObsT3o/3kw66FL5yaROkdSYtIYzTWpgyit4ViplXEcalmbkMrJ1o
         HtIYz9QCiWyIfL3jzTklF/5hY1VuCfZOc3kfUZzyi7Aa0Mn0bMKQWZAfX1RPtKmY5WcD
         mxxqphx3cGJHo2uPpkySeAimfrvswzcYhAOgH2C/dR3RiBkhGKaTS82rBuFl7hxbzcVg
         5vuTt/4ZmtDLmjna/d8Htav5VH+WUWb9LK5ynQoAvvTD3RbeNa8E00Q+DyHhZfkFW8lG
         v2WRzhvDjeKtskehltSpy1J9JLo7yo79f6Zf5e56zdCAi5mLFA4ryiWqYF+mawRzLB/Y
         9tRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775824561; x=1776429361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g5J4QxMaotyWS841K4tfeJFjDiBCE/6Zj3Tj9mZiSxY=;
        b=FQ8qoaZdTJK6NUCPXVElYckc8asoRU1HOfXRRQVORuqw4fKohrjQSgJZxX5rkuekmA
         Y3e5COA71qKPaHUQgozuKW4qfAxjmQCOEtrThk7YY4obCT/RTUopddnrd5VqOUBVyF+M
         +aVlP9icoHC4jrHVjl91OZ13aPmojOSH8GfBVWcdFdOkuYl181B8IN2PdVAeWEJCjVKj
         HZ1G7t6X8DDbGhI41uOGhvfWoDwhffrdKZT4jHb0RTmL445C1kqKjLkMlKnBmeY9BEPG
         v2TR0KIdOZnIZismNg7JEsw+rv8f3eOHD7moi+QPuudxR87rcoGMBB1Cnamn4aTnwsEh
         1d2A==
X-Gm-Message-State: AOJu0YxgkZ/31G3PEsiLJP4WfKmcypaiDo702VRPUNiMus+5wjNP/Fpz
	L51bD3LW9iAlb1alWJcNiANrViQ3x0ccZyTvXaM/UJ2AM8VWgaXmIedZPx6FFZC5wMXlfNzBEh6
	sVBNB1tblk5adGRS2W+603cV+e0+NErGPuDNINMesiWXm6wVt5y724Qc=
X-Gm-Gg: AeBDiesrIORLsqS5a8f0Xma8y8PRsbMMtz96Te6J8uQl0KVYwdQdH5+gXVKGcg2Wsqf
	jORgISf6nBeJ4h9tnxlwi6YvXyWEBYZ/BzHHjXJo7D3CS0p6doqk8oLYLVvI75R6tgokVn5nVoZ
	cVJ/chakrgwHOIxwEa0bKbocjw8GBOuErliaWWJZ5nT5qCAVUZTU/2ET2WZKJMZ9dxsqXxyTrCh
	FBoFeh+eoZ2XJXxfYp7Pr7sSr4oHCjgKWVIJkhGzH01+TDUwEzZW2rLtY7ZBBlRvsdw50YLp8/k
	ucbd2EpeK1HHnRI4VaGdu7sxuKsOqZdSwxEh5w==
X-Received: by 2002:a05:6512:3b11:b0:5a1:381b:fae1 with SMTP id
 2adb3069b0e04-5a3ef8fd63emr1219768e87.10.1775824561064; Fri, 10 Apr 2026
 05:36:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <660c10e6-f8b5-46e2-a424-e3e052992b3a@gmail.com>
 <2d5de14a-17d2-4d08-992e-cbc5d430e231@linaro.org> <20260313144508.GA5446@cventin.lip.ens-lyon.fr>
In-Reply-To: <20260313144508.GA5446@cventin.lip.ens-lyon.fr>
From: Thorsten Kukuk <kukuk@suse.com>
Date: Fri, 10 Apr 2026 14:35:49 +0200
X-Gm-Features: AQROBzArSFfIiO2VXc7LMGcNpLBCIDOn1Vma2d3qfz8GDhDkrpDnJYgPEh_f5Ks
Message-ID: <CABMvmLsdgEP4sw=6YHLZxU3pHNs5fXYjQwew9ixRT0+3+b-OPA@mail.gmail.com>
Subject: Re: [RFC] Modernizing Linux authentication logs (lastlog, btmp, utmp,
 wtmp) with SQLite
To: linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, 
	audit@vger.kernel.org, libc-alpha@sourceware.org
Cc: Roman Bakshansky <bakshansky.lists@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6079-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kukuk@suse.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vinc17.net:email,mail.gmail.com:mid,thkukuk.de:url,suse.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BB1E03D7CE7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 3:45=E2=80=AFPM Vincent Lefevre <vincent@vinc17.net=
> wrote:
>
> On 2026-03-13 10:59:11 -0300, Adhemerval Zanella Netto wrote:
> > From the glibc standpoint my plan is just to make the accounting databa=
se
> > function no-op [1] (I hopefully to get this in the next 2.44 release).
> >
> > And I think Thorsten Kukuk already adapted most of the usages in curren=
t
> > distros [2][3] using similar strategy, along with a better systemd
> > integration.  I am not sure if/when distros are incorporating his work.
> >
> > [1] https://patchwork.sourceware.org/project/glibc/list/?series=3D37271
> > [2] https://www.thkukuk.de/blog/Y2038_glibc_lastlog_64bit/
> > [3] https://www.thkukuk.de/blog/Y2038_glibc_utmp_64bit/
>
> FYI, utmp has been reintroduced in Debian for libutempter (and thus
> applications that use this library), because systemd was not working
> or at least not sufficiently documented:
>
>   https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1125682

They introduced the old "hack" to get "wall" working without solving
the problem.
What will happen now again: all people having xterm running will get
the wall message in all terminals.
People not using a terminal (so most of the normal users, not
developers) will not see this message, because web browsers and other
graphical applications don't show them.
The correct solution is, that the desktop environments register a
session, and if there is a wall message, show that in an own dialog,
so that everybody get's the message once. Not the one person 50 times,
the others not at all.

Regards,
Thorsten

--=20
Thorsten Kukuk, Distinguished Engineer, Future Technologies
SUSE Software Solutions Germany GmbH, Frankenstra=C3=9Fe 146, 90461
Nuernberg, Germany
Gesch=C3=A4ftsf=C3=BChrer: Jochen Jaser, Andrew McDonald, Werner Knoblich, =
(HRB
36809, AG N=C3=BCrnberg)

