Return-Path: <linux-api+bounces-3209-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEBEA3682D
	for <lists+linux-api@lfdr.de>; Fri, 14 Feb 2025 23:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E889188F5E3
	for <lists+linux-api@lfdr.de>; Fri, 14 Feb 2025 22:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D3E1FC0EB;
	Fri, 14 Feb 2025 22:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="AYI3ypP0"
X-Original-To: linux-api@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05ADD1DBB13;
	Fri, 14 Feb 2025 22:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739571333; cv=none; b=nPsudbrQLMo9dhq8UeGi5qyseGm1k71EGq8E9kPaJJNalU7+VHdU+caKaotyaeJZwI9lVjNbffaAfwDnBTEpQnkf/t0Gtu3csYz0YoUbu9qVX+D6l7VrmhztVTFYoGyWAmx1mCVx+1fO1epnaVDHAzsgZHW2N7oxuBXFEBxQLu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739571333; c=relaxed/simple;
	bh=qHfNqf+QN3zUphLZIVZOICnyQT2Grb5MZ/yH4/TFz7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U3H6TfT6pC4Gda2Tz5aDA1pSKrW0hwHG2Gl+CCqIAClI8zW3LV9zREsAsjKKFnLbdRPE5f/zMMB9a85IV8Kd3tPrccMhPm/6XzlVFzOY0XUqXNU1f8KpHLkmrUXojREdC3TzS6uYTdeqFpXcJFdK6EvEIeOs7Io1gBosqbY44S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=AYI3ypP0; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=I0IhT0mc+XHh3BXlnTahD96TPJaXiUlmBOqneBr1ZI0=; b=AYI3ypP086pqtMXu7a2F2eDY5m
	17BkYfHf/ffomAiQvs7DK28dyZa9II1xqbFJ/D2ypp37uLa62hy//FOnIId7e1ZB+bvXz5phgecS6
	DlnyT0bnpfVFKSDzrzwtK1WFptBSwacMrOdXwG5qIPuFTR6nwciC4juZ6niUWPQ8XDD8s4/AWP2LB
	sB3NWHoRBeqBPs6hBBBn0N7hE7kvyhqqQyib+ufTlPHVRdA2s7CevAe7EJy96ErXUglLWDQO8YTxk
	u0eBJidUF9VztwOAeIZwUHcYIjXSZnGd8PogNEoW3Z88ASoCLuWSN7lNya/tkQs21HSar6PtcyNbh
	4DKRNLig==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.localnet)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1tj3y1-00EdlQ-2C;
	Fri, 14 Feb 2025 16:15:25 -0600
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
Date: Fri, 14 Feb 2025 16:15:25 -0600
Message-ID: <8487800.T7Z3S40VBb@camazotz>
In-Reply-To: <20250214184539.GC21799@frogsfrogsfrogs>
References:
 <20250214122759.2629-2-mike@fireburn.co.uk> <1911589.tdWV9SEqCh@camazotz>
 <20250214184539.GC21799@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Friday, 14 February 2025 12:45:39 CST Darrick J. Wong wrote:
> On Fri, Feb 14, 2025 at 12:13:03PM -0600, Elizabeth Figura wrote:
> > On Friday, 14 February 2025 07:06:20 CST Greg Kroah-Hartman wrote:
> > > On Fri, Feb 14, 2025 at 12:28:00PM +0000, Mike Lothian wrote:
> > > > This allows ntsync to be usuable by non-root processes out of the b=
ox
> > >=20
> > > Are you sure you need/want that?  If so, why?  How did existing testi=
ng
> > > not ever catch this?
> >=20
> > Hi, sorry, this is of course my fault.
> >=20
> > We do need /dev/ntsync to be openable from user space for it to be
> > useful. I'm not sure what the most "correct" permissions are to have
> > in this case (when we don't specifically need read or write), but I
> > don't think I see a reason not to just set to 666 or 444.
> >=20
> > I originally assumed that the right way to do this was not to set the
> > mode on the kernel file but rather through udev; I believe I was using
> > the code for /dev/loop-control or /dev/fuse as an example, which both
> > do that. So I (and others who tested) had just manually set up udev
> > rules for this, with the eventual intent of adding a default rule to
> > systemd like the others. I only recently realized that doing something
> > like this patch is possible and precedented.
> >=20
> > I don't know what the best way to address this is, but this is
> > certainly the simplest.
>=20
> Paranoid defaults in the kernel, and then a udev rule to relax the mode
> at runtime.  You could also have logind scripts to add add per-user
> allow acls to the device file at user session set up time... or however
> it is that /dev/sr0 has me on the allow list.  I'm not sure how that
> happens exactly, but it works smoothly.
>=20
> I get far less complaining about relaxing posture than tightening it
> (=3D=3Dbreaking things) after the fact.

=46WIW, it may be worth stressing that this is not a hardware device in any=
 sense, it's a software driver that only lives in a char device (and dedica=
ted module) for the sake of isolating the code. I can't imagine any reason =
to control access per-user, although my experience may not be enough to gra=
nt such imagination.

The only actual risk is a bug in the code itself=E2=80=94which is always po=
ssible=E2=80=94but at that point you'd presumably just want to disable it a=
t build time or something similar.



