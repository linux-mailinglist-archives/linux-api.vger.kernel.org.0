Return-Path: <linux-api+bounces-5154-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F84C3ED1F
	for <lists+linux-api@lfdr.de>; Fri, 07 Nov 2025 08:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3314E3ADA8A
	for <lists+linux-api@lfdr.de>; Fri,  7 Nov 2025 07:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3045F2D7DD9;
	Fri,  7 Nov 2025 07:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="r5pOpe4t"
X-Original-To: linux-api@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B59171C9;
	Fri,  7 Nov 2025 07:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762502007; cv=none; b=hcW9dr0dJkdwLcdJs1qfstuq1q1LEGVx5qzw+TDO5N4Z2CgZXSWqeW5IcpRYBWwd+JnXImqQdM+PnVdjSE+S038axv2BjZLHjRqMvhj48vvABHn+IX0QV//f7UojhH2Lvxoyoq1jbjpjgBcqcl48RwrZuohI30z3vPGPFzBG/MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762502007; c=relaxed/simple;
	bh=AA6TmhKQwv4AebnM5l1TN7JJbHA4LEPZvZtXyrTR6DE=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=DXPyeTAruB8Ocukrc8PyPpUbQc3B/+Qxz7Kqmoym0owYqTnU1z7teKg4CgYSIpxgGTY2VyD17tdskcDwHFA26pnW/uvKINPEuAGU3Lall4cJmG0huU3pqDB1s2jX16S/us6R8/OX8EeT+VGr7I11gtLGzYl32sG22R+9VhcdYUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=r5pOpe4t; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [172.27.2.41] (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 5A77rNgf1535660
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 6 Nov 2025 23:53:24 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 5A77rNgf1535660
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025102301; t=1762502004;
	bh=7r+n1p+X1cbofwYc3EO9YiEEuS/TA07k3XwXk8V2uZo=;
	h=Date:To:From:Subject:From;
	b=r5pOpe4t0RPCbbYghR8/88E+5UdJ7nY4ogQ8vLC4ixmp22mJlb+N2MxdKnlZbs62g
	 EjGv3G6T4Jgk9o7UNh1sbpvA16G3EkgCTvDeHBi+KptuFZhRRK8oO8elmmvTomQJuG
	 tSAt6hmdgwOOVgp+3GCd+CIBT9EIMh+qYZow9WX73FZEOsb0tTOsSIRJL5/CJ6BQQO
	 TrgLhWlv/CoIoctSAA3qX4fW65M7DHEeA8WYBS2/o6w8yOn/7WV1Wl5EkzD2DrOQTr
	 YPIItRq3G8cUQcEmVopFo/IV7xyTxdf4yoBIad1u+nFumDaOCpzXFFI//ssWD8jfl6
	 RylYG6OlpL6Uw==
Message-ID: <bb44f856-10a2-40c7-a3f7-be50c8e4b0a9@zytor.com>
Date: Thu, 6 Nov 2025 23:53:23 -0800
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, sv-SE
To: linux-serial@vger.kernel.org, linux-api@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: RFC: Serial port DTR/RTS - O_NRESETDEV
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

I recently ran into a pretty serious issue due to the Unix/Linux (mis)behavior
of forcing DTR and RTS asserted when a serial port is set, losing the
pre-existing status in the process. Since it is impossible probe for the
current status or even if it is a functional serial port without a file
descriptor, this is very problematic. This came up in the context of probing
for serial ports from an application, so even if termios could be modified
without a file descriptor (which it can't) it would not be safe.

I noted there was a patchset for that on linux-serial from 2022 which
apparently got dropped and never merged, but I think it has a pretty serious
problem: it used a sysfs setting to control the behavior, which may be
reasonable for a default, but at the end of it this is really something that
is determined by the intent of the open() call, just like O_NONBLOCK replaced
the old callout devices we once had.

It seems to me that this may very well be a problem beyond ttys, in which case
a new open flag to request to a driver that the configuration and (observable)
state of the underlying hardware device -- whatever it may be -- should not be
disturbed by calling open(). This is of course already the case for many
devices, not to mention block and non-devices, in which case this flag is a
don't care.

The best name I came up with was O_NRESETDEV, but it's not something I'm
particularly attached to.

If the opinion is that this *doesn't* have a scope beyond ttys, then perhaps
abusing the O_DIRECT flag for this purpose would be an alternative.

Thoughts?

	-hpa


