Return-Path: <linux-api+bounces-4644-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 444B8B39F3F
	for <lists+linux-api@lfdr.de>; Thu, 28 Aug 2025 15:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6E7E3A7057
	for <lists+linux-api@lfdr.de>; Thu, 28 Aug 2025 13:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE8020C001;
	Thu, 28 Aug 2025 13:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.ucla.edu header.i=@cs.ucla.edu header.b="mVlaH1s7"
X-Original-To: linux-api@vger.kernel.org
Received: from mail.cs.ucla.edu (mail.cs.ucla.edu [131.179.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C0013C9C4
	for <linux-api@vger.kernel.org>; Thu, 28 Aug 2025 13:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.179.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756388610; cv=none; b=C9v734pSfcHgVmcObqLqqc5PXmXBqtgidsDLc+2Ccyayx9vpjlccNz+YSFlag79j+FeJgalBvoZMfP7VEqDbm2svK+tf0jrXycFothDOg5TdhcZKPzKghoP//KX0Fu68XlD5ksexgQ7EM2XJ4/KhExXpauOh/rV/khbepNg/6IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756388610; c=relaxed/simple;
	bh=Gfp1kWMiqlQaDH75GF0a0OajZGhAwbWmYbkx1zy/YVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qyw5yXw1wZNRzXqsn/zkeajWgCifvwgilLvVmg/MRpU23BwlcG50WsUP2GolEukss7F7YnnIsbKu4XcmI4q2jskAx3iDtb5C+yR2nhbWucB4nXz5hy6hhE5umjS2BtxYeLNfsT9+HfOMQ6qlE7vuqgRyELNlZKczA3a6U97kRVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.ucla.edu; spf=pass smtp.mailfrom=cs.ucla.edu; dkim=pass (2048-bit key) header.d=cs.ucla.edu header.i=@cs.ucla.edu header.b=mVlaH1s7; arc=none smtp.client-ip=131.179.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.ucla.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.ucla.edu
Received: from localhost (localhost [127.0.0.1])
	by mail.cs.ucla.edu (Postfix) with ESMTP id 32E793C0149F6;
	Thu, 28 Aug 2025 06:43:28 -0700 (PDT)
Received: from mail.cs.ucla.edu ([127.0.0.1])
 by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavis, port 10032) with ESMTP
 id eQJYZaxMe1Js; Thu, 28 Aug 2025 06:43:28 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.cs.ucla.edu (Postfix) with ESMTP id 088E63C32B0FD;
	Thu, 28 Aug 2025 06:43:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.cs.ucla.edu 088E63C32B0FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.ucla.edu;
	s=9D0B346E-2AEB-11ED-9476-E14B719DCE6C; t=1756388608;
	bh=frJuCsg5GjM12xqGOoW6BxFOcUJwQm4Yl907MoZaibQ=;
	h=Message-ID:Date:MIME-Version:To:From;
	b=mVlaH1s7MnZGfkc3L2DzbncFg8apDiJolH4xlGAa/Jb9MQeS2qQGOlAGcD8srztQ0
	 NwP1AwYzj6WoXKuOR/88iev2DFaSD3U8APFmYc0meq+hsKc6fgrMh3W+fbdyk7/O6N
	 I0vpx7NIHqUoEeybnUttmeNy6vZNyffMR+AGqMCwAQlS0Ltmmk1UGVvqjD0lQ3M59+
	 VtJxcL4P8lYxJFMgwPIoiAAdkusmp4DpqcZJVTVlaEDCWsa6wzo3v8Lri7rDNTNl9A
	 0jH6FNAiy9FjGgFJ6X7EZT2t4nmhAW/hORdm6GiEUBIHtHzPTDJmHMisVy7tQkizEB
	 6t91LvkQBUJaw==
X-Virus-Scanned: amavis at mail.cs.ucla.edu
Received: from mail.cs.ucla.edu ([127.0.0.1])
 by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavis, port 10026) with ESMTP
 id 6pgaj_F-W9ds; Thu, 28 Aug 2025 06:43:27 -0700 (PDT)
Received: from penguin.cs.ucla.edu (47-154-18-19.fdr01.snmn.ca.ip.frontiernet.net [47.154.18.19])
	by mail.cs.ucla.edu (Postfix) with ESMTPSA id D367C3C0149F6;
	Thu, 28 Aug 2025 06:43:27 -0700 (PDT)
Message-ID: <cbbc9639-0443-4bf8-bbd1-9d3fdcb2fd37@cs.ucla.edu>
Date: Thu, 28 Aug 2025 06:43:27 -0700
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] linux: Add openat2 (BZ 31664)
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
 Arjun Shankar <arjun@redhat.com>, libc-alpha@sourceware.org,
 linux-api@vger.kernel.org
References: <2c5ae756-c624-4855-9afb-7b8e8ce91011@linaro.org>
 <828f6dfb-7402-45e1-a9ed-9e17b6356c5c@linaro.org>
 <2025-08-25.1756160579-pudgy-swank-chard-regalia-j3jdtD@cyphar.com>
 <5c3b9baf-76b4-40d7-87fb-9b8dd5afd1ee@cs.ucla.edu>
 <2025-08-26.1756212515-wealthy-molten-melody-nobody-a5HmWg@cyphar.com>
 <6432a34d-fba9-414e-ad38-d3354fa0d775@cs.ucla.edu>
 <2025-08-27.1756273344-decaf-ominous-thrift-twinge-h1gGBI@cyphar.com>
 <5c9fa556-da00-4b76-8a70-8e2d1dddd92d@cs.ucla.edu>
 <2025-08-27-perky-glossy-dam-spindle-kPpnnk@cyphar.com>
 <5cbd7011-9c2a-4a23-bbce-84c100877cdb@cs.ucla.edu>
 <2025-08-28-foreign-swampy-comments-arbor-nOkpXI@cyphar.com>
Content-Language: en-US
From: Paul Eggert <eggert@cs.ucla.edu>
Organization: UCLA Computer Science Department
In-Reply-To: <2025-08-28-foreign-swampy-comments-arbor-nOkpXI@cyphar.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-08-28 01:42, Aleksa Sarai wrote:
>> I still fail to understand how a hypothetical "give me the supported flags"
>> openat2 flag would be useful enough to justify complicating the openat2 API
>> today.
> My only concern is that it would break recompiles if/when we change it
> back.

OK, but from what I can see there's no identified possibility that 
openat2 will modify the objects its arguments point to, just as there's 
no identified possibility that plain openat will do so (in a 
hypothetical extension to remove unnecessary slashes from its filename 
argument, say).

In that case it's pretty clear that glibc should mark the open_how 
argument as pointer-to-const, just as glibc already marks the filename 
argument.

