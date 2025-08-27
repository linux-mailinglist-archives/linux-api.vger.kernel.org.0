Return-Path: <linux-api+bounces-4636-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8652B38F40
	for <lists+linux-api@lfdr.de>; Thu, 28 Aug 2025 01:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E908E1C235FA
	for <lists+linux-api@lfdr.de>; Wed, 27 Aug 2025 23:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416CA310627;
	Wed, 27 Aug 2025 23:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.ucla.edu header.i=@cs.ucla.edu header.b="HLkdEoH3"
X-Original-To: linux-api@vger.kernel.org
Received: from mail.cs.ucla.edu (mail.cs.ucla.edu [131.179.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E21C30F94E
	for <linux-api@vger.kernel.org>; Wed, 27 Aug 2025 23:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.179.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756337297; cv=none; b=QNwatPsawlKi9Sn/Y9NIhgIM75DFZcaBqfZVh3zVWlhYI5EC2QcS5CwPBR3b+/IQxoPOBia7P8uKYPdCD4Y3o5twOzdV1VaWnM4WUubtMkOO8ObuWUm8YhG0FUepSYEYx+eZIqxq71hiIslmJ7OGkprAuaRN8tiqopMWJJ73XN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756337297; c=relaxed/simple;
	bh=1iMwE0fNK7flXnZ1rGV03oxu+UtYW7kR/Ox8zaEFrUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=njmAXQaP79sLcm068BQRJ261afMrRaZcBsMaLGVdGyaImQUDFlqj7JQdxS3ig50Uv14S9oWUw0etECoXa3ggc+ftjjpSyibOjMTCMFSpXYg6cyEhKbh4c2mGIHXV2KL99eKhKVLhMRlj0WurYnMqPQcKiIStmbUSJarHoTdtwsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.ucla.edu; spf=pass smtp.mailfrom=cs.ucla.edu; dkim=pass (2048-bit key) header.d=cs.ucla.edu header.i=@cs.ucla.edu header.b=HLkdEoH3; arc=none smtp.client-ip=131.179.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.ucla.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.ucla.edu
Received: from localhost (localhost [127.0.0.1])
	by mail.cs.ucla.edu (Postfix) with ESMTP id 7EE413C306706;
	Wed, 27 Aug 2025 16:19:06 -0700 (PDT)
Received: from mail.cs.ucla.edu ([127.0.0.1])
 by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavis, port 10032) with ESMTP
 id D4lrCWtuCiyo; Wed, 27 Aug 2025 16:19:06 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.cs.ucla.edu (Postfix) with ESMTP id 546453C30671E;
	Wed, 27 Aug 2025 16:19:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.cs.ucla.edu 546453C30671E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.ucla.edu;
	s=9D0B346E-2AEB-11ED-9476-E14B719DCE6C; t=1756336746;
	bh=JWPtkcF50MDfHBcxlwuYB/yYrbEiAfUZ06MbRjnXBEs=;
	h=Message-ID:Date:MIME-Version:To:From;
	b=HLkdEoH3NasYDJM/Emz3lP9saeZGrYw7t3OEHA749h2LuNhV+v70ztti68b3J2SJI
	 jxvRTTuaXBcZBuZ7+QcvQbzyC8irHyUJlva3s51ojXKVkTHptboHzjlsZXSanFG3vj
	 G70qJTNJpMhnjMmQU61FwX4YKdBQjg9Oc6NhZMdTqx6vUMEeht8uKCTg/KE6dFN+zI
	 Ec8NHPi0WaCvrkcdRDqm/UJR3+Eb7D1NZ8TXzMSDqk9ctwrT2QRqW5Qdcgpm++8yqi
	 ijw5eW2GdnJ50pZ9+nE4feCxQHRD2sdD+e9NaIIUyRmgiYkGNtdV08WQKO5FWVZtoq
	 TBO8pM56bSIHg==
X-Virus-Scanned: amavis at mail.cs.ucla.edu
Received: from mail.cs.ucla.edu ([127.0.0.1])
 by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavis, port 10026) with ESMTP
 id vfLZI1YJKyDe; Wed, 27 Aug 2025 16:19:06 -0700 (PDT)
Received: from penguin.cs.ucla.edu (47-154-18-19.fdr01.snmn.ca.ip.frontiernet.net [47.154.18.19])
	by mail.cs.ucla.edu (Postfix) with ESMTPSA id 2A7703C30671D;
	Wed, 27 Aug 2025 16:19:06 -0700 (PDT)
Message-ID: <5cbd7011-9c2a-4a23-bbce-84c100877cdb@cs.ucla.edu>
Date: Wed, 27 Aug 2025 16:19:04 -0700
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
References: <5d4eaca9-930c-4fca-bdbd-5174733642ee@cs.ucla.edu>
 <b34176ff-883b-4a3d-b48a-8c6421f53ec7@cs.ucla.edu>
 <2c5ae756-c624-4855-9afb-7b8e8ce91011@linaro.org>
 <828f6dfb-7402-45e1-a9ed-9e17b6356c5c@linaro.org>
 <2025-08-25.1756160579-pudgy-swank-chard-regalia-j3jdtD@cyphar.com>
 <5c3b9baf-76b4-40d7-87fb-9b8dd5afd1ee@cs.ucla.edu>
 <2025-08-26.1756212515-wealthy-molten-melody-nobody-a5HmWg@cyphar.com>
 <6432a34d-fba9-414e-ad38-d3354fa0d775@cs.ucla.edu>
 <2025-08-27.1756273344-decaf-ominous-thrift-twinge-h1gGBI@cyphar.com>
 <5c9fa556-da00-4b76-8a70-8e2d1dddd92d@cs.ucla.edu>
 <2025-08-27-perky-glossy-dam-spindle-kPpnnk@cyphar.com>
Content-Language: en-US
From: Paul Eggert <eggert@cs.ucla.edu>
Organization: UCLA Computer Science Department
In-Reply-To: <2025-08-27-perky-glossy-dam-spindle-kPpnnk@cyphar.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-08-27 15:48, Aleksa Sarai wrote:
> On 2025-08-27, Paul Eggert <eggert@cs.ucla.edu> wrote:
>> What specific scenario would make the "give me supported flags" flag worth
>> the hassle of supporting and documenting and testing such a flag?
> 
> "Just try it" leads to programs that have to test dozens of flag
> combinations for syscalls at startup,

Although that sort of thing can indeed be a problem in general, I don't 
see how it's a problem for openat2 in particular.

The issue here is whether openat2's API should reflect current behavior 
(where the HOW argument is pointer-to-const) or a potential future 
behavior (where the kernel might modify the struct that HOW points to, 
if some hypothetical future flag is set in that struct). I am skeptical 
that this hypothetical situation is so plausible that it justifies the 
maintenance hassle of a glibc API that doesn't correspond to how openat2 
currently behaves.


> A simple example would be mounts -- if MOUNT_BENEATH is not supported

I don't understand this example. Are you talking about <linux/mount.h>'s 
MOVE_MOUNT_BENEATH? That's a move_mount flag, and I don't see what that 
has to do with openat2. Or are you saying that openat2 might not support 
<linux/openat2.h>'s RESOLVE_BENEATH flag? Under what conditions might 
that be, exactly? Can you give some plausible user code to illustrate 
the openat2 example you're thinking of?

I still fail to understand how a hypothetical "give me the supported 
flags" openat2 flag would be useful enough to justify complicating the 
openat2 API today.

