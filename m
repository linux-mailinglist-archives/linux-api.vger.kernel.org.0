Return-Path: <linux-api+bounces-3211-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AB8A36AD5
	for <lists+linux-api@lfdr.de>; Sat, 15 Feb 2025 02:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D91047A4711
	for <lists+linux-api@lfdr.de>; Sat, 15 Feb 2025 01:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343133B1A4;
	Sat, 15 Feb 2025 01:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="Xg851AJR"
X-Original-To: linux-api@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865813595D;
	Sat, 15 Feb 2025 01:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739582650; cv=none; b=CwpesJzKzBj8XSqD+pvS+V/0AtOnRoaXRWyMU2K+9rNtNIv3/+W+q+IaVG/o86ALPfhyKM2nghiL7eC5CngwZvqzFebsb5cZRMgH6rUbOr0dNd3+X2APe/Ytgvyb8LasqyywcOzv1Su150sQYisZWid0bSDs9KsYDtwHNed9KXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739582650; c=relaxed/simple;
	bh=/8rvox9DOC/NPAqTp23c5M8ih+i+QiAgWnjovlqOJAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZGJmVsaqYxTzVkrhK8tepIgiujsq+Kj3rjQ5bRpTtFoMyll4L6VviEgACaOCVglY0U/fUKZjqgahRcy6y/G67Xbj/lXcQRVx5v7pQpm9S0B3AtFfx6laQnwwXQ53spux8z6OUh1l7neIeKwRoC7zg0GjyYPezGVheLmwk+XamUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=Xg851AJR; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jw3SBcHfeO9xQcGCOZ7HTEtBaz2w2sb/NeaKrxms458=; b=Xg851AJRGjCCqkRvuy7GRRgRfX
	H5E1t1Tj34t9hcjE+oxOrjHfSsrW9ObUB8wJCcMYybXtVeHFM5lX2wzn/VN/gjdduvPYx1Bs0pr96
	UDjNDXenZimieCUy0+TSI0ioR41jlkJCOVfYbrRzIL38ZAZSXMLFKHxaYOHH7QxO1UiISo/pOJ44Y
	MBTqnzjs0TiGhW9x758kJc6QxRDBfpCB32GB7A/rCk21kHUZwTjNPzt3LNiZwYKA/+M7mEifytO4U
	txWBv4aOZDsqZE/C8+o/jPlw/vflDDCzAiU/9ysdRQjZ6XQKG656jftEGvyBKLVQNgULZ6iUNy6hC
	tC2BYddg==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.localnet)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1tj6uW-00FC1C-2T;
	Fri, 14 Feb 2025 19:24:00 -0600
From: Elizabeth Figura <zfigura@codeweavers.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Mike Lothian <mike@fireburn.co.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 dri-devel@lists.freedesktop.org, Arnd Bergmann <arnd@arndb.de>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 wine-devel@winehq.org, =?UTF-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
 Wolfram Sang <wsa@kernel.org>, Arkadiusz Hiler <ahiler@codeweavers.com>,
 Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
 Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH] ntsync: Set the permissions to be 0666
Date: Fri, 14 Feb 2025 19:24:00 -0600
Message-ID: <3611179.iIbC2pHGDl@camazotz>
In-Reply-To: <20250215010333.GO3028674@frogsfrogsfrogs>
References:
 <20250214122759.2629-2-mike@fireburn.co.uk> <8487800.T7Z3S40VBb@camazotz>
 <20250215010333.GO3028674@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Friday, 14 February 2025 19:03:33 CST Darrick J. Wong wrote:
> On Fri, Feb 14, 2025 at 04:15:25PM -0600, Elizabeth Figura wrote:
> > On Friday, 14 February 2025 12:45:39 CST Darrick J. Wong wrote:
> > > On Fri, Feb 14, 2025 at 12:13:03PM -0600, Elizabeth Figura wrote:
> > > > On Friday, 14 February 2025 07:06:20 CST Greg Kroah-Hartman wrote:
> > > > > On Fri, Feb 14, 2025 at 12:28:00PM +0000, Mike Lothian wrote:
> > > > > > This allows ntsync to be usuable by non-root processes out of t=
he box
> > > > >=20
> > > > > Are you sure you need/want that?  If so, why?  How did existing t=
esting
> > > > > not ever catch this?
> > > >=20
> > > > Hi, sorry, this is of course my fault.
> > > >=20
> > > > We do need /dev/ntsync to be openable from user space for it to be
> > > > useful. I'm not sure what the most "correct" permissions are to have
> > > > in this case (when we don't specifically need read or write), but I
> > > > don't think I see a reason not to just set to 666 or 444.
> > > >=20
> > > > I originally assumed that the right way to do this was not to set t=
he
> > > > mode on the kernel file but rather through udev; I believe I was us=
ing
> > > > the code for /dev/loop-control or /dev/fuse as an example, which bo=
th
> > > > do that. So I (and others who tested) had just manually set up udev
> > > > rules for this, with the eventual intent of adding a default rule to
> > > > systemd like the others. I only recently realized that doing someth=
ing
> > > > like this patch is possible and precedented.
> > > >=20
> > > > I don't know what the best way to address this is, but this is
> > > > certainly the simplest.
> > >=20
> > > Paranoid defaults in the kernel, and then a udev rule to relax the mo=
de
> > > at runtime.  You could also have logind scripts to add add per-user
> > > allow acls to the device file at user session set up time... or howev=
er
> > > it is that /dev/sr0 has me on the allow list.  I'm not sure how that
> > > happens exactly, but it works smoothly.
> > >=20
> > > I get far less complaining about relaxing posture than tightening it
> > > (=3D=3Dbreaking things) after the fact.
> >=20
> > FWIW, it may be worth stressing that this is not a hardware device in
> > any sense, it's a software driver that only lives in a char device
> > (and dedicated module) for the sake of isolating the code. I can't
> > imagine any reason to control access per-user, although my experience
> > may not be enough to grant such imagination.
>=20
> Oh, I'm aware that ntsync is a driver for a software "device" that
> implements various Windows APIs and isn't real hardware. :)
>=20
> But, you might want prevent non-root systemd services (e.g. avahi) from
> being able to access /dev/ntsync if, say, someone breaches that, while
> at the same time allowing access to (say) logged-in users who can run
> Wine.

I see the idea, though I don't know if it's applicable in this case=E2=80=
=94the individual ntsync file descriptions are also supposed to be isolated=
 from one another, so even a rogue avahi would still have another barrier t=
owards compromising a Wine process. Of course you may be aware of that and =
be advocating for the more barriers the better.

I can't say what systemd will actually prefer in this case, but they do see=
m to have requested that the kernel change it... [1]

[1] https://github.com/systemd/systemd/pull/36384



