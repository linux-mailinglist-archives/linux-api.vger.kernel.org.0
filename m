Return-Path: <linux-api+bounces-3205-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D741A36588
	for <lists+linux-api@lfdr.de>; Fri, 14 Feb 2025 19:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D22D1891C26
	for <lists+linux-api@lfdr.de>; Fri, 14 Feb 2025 18:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536FC268FEA;
	Fri, 14 Feb 2025 18:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="jNDFOzmu"
X-Original-To: linux-api@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE15268FD7;
	Fri, 14 Feb 2025 18:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739556799; cv=none; b=qF5HSrla9AM9nVc4ZvevzOXY4fZrCU50Nm8AKz1TV/n7PWsq7eweZsQpdgkGNiMsih7EIvApQCYWfHmqBMKfhuqSLYTeJwi9ommJ8ddMRXEr/AFqyag8QLXNj5d9CfZehrBuWTt4RuQByo0i6brCF1PY+z8bYF2tdkbAOLOTLlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739556799; c=relaxed/simple;
	bh=ngDM7lYzV4PmPRzszER3Db06NN1lDVQgrcWJGbyAzkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mM1uUximn5m+owmdA/eVrwtJIQXzqjZS928O8ZhDtdc40bC0+lOysTZMmUBeVmYmCg1tRKZV6bceAJSqBt66q9aba+yXNKTvIadPknXzVC4VDramWth5Jhz2CQFuJW6j6BcH79+x97aUxMBxJZmN5PsdNj4fd9oEAkcQgm4Wg9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=jNDFOzmu; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=mg29O1IWvz6AYrtMgt2bPfsw5RmrLKeehUhBhUOdQIY=; b=jNDFOzmuvMoKoCXGiFtVfob5ap
	y+MMBpQ9ZkI15CEF72uJt5S/DhA23yquETfZ6oVPqIxJi3ZVXT1VhW6eVMaj7Ic1LURuCy5Ca8Lhq
	zSzN8cvjGFUbOezj2rfA2NnlEltofQyTPdCuxLO9SzHlo6s/Snf9DgG1E1DvKaV7e0kWDxPi3VX1x
	uq4K8b0pcdBSESfgQ0wEwrzjOvUEi25j4Mg4M341Wgear6GGUYEdEo/EgIxdP+WC79f10PN0m1taT
	CgRz770wx5CRLZNZGzRQDnmcG5k8dKgyCA+Vrcgocca8PZCTOuj7CUgTkc5ewaxGkXQBVDYvjS1JA
	50Zq5mzQ==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.localnet)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1tj0BT-00EN9U-1p;
	Fri, 14 Feb 2025 12:13:03 -0600
From: Elizabeth Figura <zfigura@codeweavers.com>
To: Mike Lothian <mike@fireburn.co.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: dri-devel@lists.freedesktop.org, Arnd Bergmann <arnd@arndb.de>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 wine-devel@winehq.org, =?UTF-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
 Wolfram Sang <wsa@kernel.org>, Arkadiusz Hiler <ahiler@codeweavers.com>,
 Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
 Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH] ntsync: Set the permissions to be 0666
Date: Fri, 14 Feb 2025 12:13:03 -0600
Message-ID: <1911589.tdWV9SEqCh@camazotz>
In-Reply-To: <2025021456-easiness-facebook-636e@gregkh>
References:
 <20250214122759.2629-2-mike@fireburn.co.uk>
 <2025021456-easiness-facebook-636e@gregkh>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Friday, 14 February 2025 07:06:20 CST Greg Kroah-Hartman wrote:
> On Fri, Feb 14, 2025 at 12:28:00PM +0000, Mike Lothian wrote:
> > This allows ntsync to be usuable by non-root processes out of the box
> 
> Are you sure you need/want that?  If so, why?  How did existing testing
> not ever catch this?

Hi, sorry, this is of course my fault.

We do need /dev/ntsync to be openable from user space for it to be useful. I'm not sure what the most "correct" permissions are to have in this case (when we don't specifically need read or write), but I don't think I see a reason not to just set to 666 or 444.

I originally assumed that the right way to do this was not to set the mode on the kernel file but rather through udev; I believe I was using the code for /dev/loop-control or /dev/fuse as an example, which both do that. So I (and others who tested) had just manually set up udev rules for this, with the eventual intent of adding a default rule to systemd like the others. I only recently realized that doing something like this patch is possible and precedented.

I don't know what the best way to address this is, but this is certainly the simplest.



