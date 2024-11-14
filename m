Return-Path: <linux-api+bounces-2735-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 455659C9277
	for <lists+linux-api@lfdr.de>; Thu, 14 Nov 2024 20:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C528B21ADD
	for <lists+linux-api@lfdr.de>; Thu, 14 Nov 2024 19:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E2D19D8B2;
	Thu, 14 Nov 2024 19:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UsXOewac"
X-Original-To: linux-api@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4878A14389F;
	Thu, 14 Nov 2024 19:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731613005; cv=none; b=D6OGfT3PeECgKcBLnX0xSO0H1NMowuilCzQt/XXkbk9+18nhD4JNlERhz+tmhWItxJFpmMGzmBbnFSk9ShSP7YgcprkgU+4qjToXMQlnwdjRusdoM2S02NAtbSEFZDJgym6AogataohbwUiWPHRLj+krdheQhG40T5PAf/ZaXho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731613005; c=relaxed/simple;
	bh=/EBrmwQU5rS3M7JeuDJfsU9fSQIlNMM7bV+MV6K5+PM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VNGIKRQOUGWqDiv4YsS87JluRVEnjg8UHTxnKa640SfnriVaEkEg0G9fQOefYAW7MxaYiTzbTakJCKSzjusStqJN1O/Is03Q5b+wgRyYKR8nC/06F9nC1wF+7dqHv8+BhVJnjf2pxVQpZ/tY6drpOCKHMxbMJdWDL4cC7+QkMrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UsXOewac; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=qW1uk/hmhiHBWlUU3XI2BHwzOgZLmpe0aMw1i+bQAyI=; b=UsXOewacG4DEMnTnSlOyzcqnXY
	lBgH+jslP/I/JjYWj8iF4T2R5q14s4D0mppHz1hvdMHt/ICl2gxBzxyyuyAnmibbm7G0mWsa2lJFI
	hoe73jIbe2QBfvelAxBrTkBvFPxmuDbYMCao5Yg4qwKmfMjaiuiD38jiq8Pzu3jhJ7Jb/rAkYmkbB
	6fRqgU+ZAcMPmfNdodkan9pW7xkdRBLrFXS0fonXoH7PLznbu0AeHa/QoGU19cV6k2osMoGbEVOvH
	xB+/uRxQfP5plzRydsD97IuIiRm5aXQ7fjlTpv+wGUI5X6JiNKnyxYvZEILm4w2iAQM00CnpyDi2n
	ffiob7Og==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tBfdx-00000000Cs2-0KLS;
	Thu, 14 Nov 2024 19:36:40 +0000
Message-ID: <e5053f9e-3dc7-4a71-9a3a-f8492987f21f@infradead.org>
Date: Thu, 14 Nov 2024 11:36:35 -0800
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 00/12] Begin upstreaming Homa transport
 protocol
To: John Ousterhout <ouster@cs.stanford.edu>,
 Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, linux-api@vger.kernel.org
References: <20241111234006.5942-1-ouster@cs.stanford.edu>
 <ZzTcx8nmEKIJpaCR@pop-os.localdomain>
 <CAGXJAmyGTwjFo6fGoROY=hQFXbR5RdpmpkEc9Zm6DOoD2nbwNA@mail.gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAGXJAmyGTwjFo6fGoROY=hQFXbR5RdpmpkEc9Zm6DOoD2nbwNA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/14/24 8:59 AM, John Ousterhout wrote:
> On Wed, Nov 13, 2024 at 9:08 AM Cong Wang <xiyou.wangcong@gmail.com> wrote:
>>
>> On Mon, Nov 11, 2024 at 03:39:53PM -0800, John Ousterhout wrote:
>>>  MAINTAINERS               |    7 +
>>>  include/uapi/linux/homa.h |  165 ++++++
>>>  net/Kconfig               |    1 +
>>>  net/Makefile              |    1 +
>>>  net/homa/Kconfig          |   19 +
>>>  net/homa/Makefile         |   14 +
>>>  net/homa/homa_impl.h      |  767 ++++++++++++++++++++++++++
>>>  net/homa/homa_incoming.c  | 1076 +++++++++++++++++++++++++++++++++++++
>>>  net/homa/homa_outgoing.c  |  854 +++++++++++++++++++++++++++++
>>>  net/homa/homa_peer.c      |  319 +++++++++++
>>>  net/homa/homa_peer.h      |  234 ++++++++
>>>  net/homa/homa_plumbing.c  |  965 +++++++++++++++++++++++++++++++++
>>>  net/homa/homa_pool.c      |  420 +++++++++++++++
>>>  net/homa/homa_pool.h      |  152 ++++++
>>>  net/homa/homa_rpc.c       |  488 +++++++++++++++++
>>>  net/homa/homa_rpc.h       |  446 +++++++++++++++
>>>  net/homa/homa_sock.c      |  380 +++++++++++++
>>>  net/homa/homa_sock.h      |  426 +++++++++++++++
>>>  net/homa/homa_stub.h      |   80 +++
>>>  net/homa/homa_timer.c     |  156 ++++++
>>>  net/homa/homa_utils.c     |  150 ++++++
>>>  net/homa/homa_wire.h      |  378 +++++++++++++
>>
>> Hi John,
>>
>> Thanks for your efforts to push them upstream!
>>
>> Just some very high-level comments:
>>
>> 1. Please run scripts/checkpatch.pl to make sure the coding style is
>> aligned with upstream, since I noticed there are still some C++ style
>> comments in your patchset.
> 
> I have been running checkpatch.pl, but it didn't complain about C++
> style comments. Those comments really shouldn't be there, though: they
> are for pieces of code I've temporarily commented out, and those
> chunks shouldn't be in the upstream version of Homa. I'll fix things
> so they don't appear in the future.
> 

John, you should be OK using // comments if that's what you want to use.

https://lkml.iu.edu/hypermail/linux/kernel/1607.1/00627.html
or
https://lore.kernel.org/lkml/CA+55aFyQYJerovMsSoSKS7PessZBr4vNp-3QUUwhqk4A4_jcbg@mail.gmail.com/

are still current AFAIK.


-- 
~Randy


