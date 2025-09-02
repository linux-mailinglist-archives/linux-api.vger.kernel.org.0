Return-Path: <linux-api+bounces-4690-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 135FBB40CFB
	for <lists+linux-api@lfdr.de>; Tue,  2 Sep 2025 20:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97B205E0AC8
	for <lists+linux-api@lfdr.de>; Tue,  2 Sep 2025 18:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D1934AB06;
	Tue,  2 Sep 2025 18:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.ucla.edu header.i=@cs.ucla.edu header.b="YPnPjbf2"
X-Original-To: linux-api@vger.kernel.org
Received: from mail.cs.ucla.edu (mail.cs.ucla.edu [131.179.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A5E33A03A
	for <linux-api@vger.kernel.org>; Tue,  2 Sep 2025 18:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.179.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756837076; cv=none; b=WIjcv+8vbvm82+uQmkOVg6HAV043glkSz04XeOIvsPJJKpBSFbPAAc2wtoxRhN9rqfEWBQhHm7XOJLRj4rK4qhLRWEfeZf7DPyY7B45XQ9/bBkYobvQ6MNqyHVsGPlY9Coql/RkeQF63zQy1BOvzuQULeJXtsmpYequf9+2PHC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756837076; c=relaxed/simple;
	bh=erFtCBWKSHmHO6sbz5M/ddIJlv7xCRivPg8/YmC+KCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=anRWR0FchrrUhCXn00JkRjsyq8insrXw/ms28TzpB+CLGMEe7f1BF0niv1dhWmGiJUsBLLlx7YBOxJYVl/V2AYGFQpevTT/vmfRkAwwLrXwlJJ2mqVby2SqkuJGCWJGVIYfDVbdPDaHPRbdRVCH5P95yeudDkfhSdPqxhPkKdZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.ucla.edu; spf=pass smtp.mailfrom=cs.ucla.edu; dkim=pass (2048-bit key) header.d=cs.ucla.edu header.i=@cs.ucla.edu header.b=YPnPjbf2; arc=none smtp.client-ip=131.179.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.ucla.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.ucla.edu
Received: from localhost (localhost [127.0.0.1])
	by mail.cs.ucla.edu (Postfix) with ESMTP id C77ED3C3068E1;
	Tue,  2 Sep 2025 11:17:54 -0700 (PDT)
Received: from mail.cs.ucla.edu ([127.0.0.1])
 by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavis, port 10032) with ESMTP
 id AwgMJhRvEs7y; Tue,  2 Sep 2025 11:17:54 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.cs.ucla.edu (Postfix) with ESMTP id 9E23C3C32B0F0;
	Tue,  2 Sep 2025 11:17:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.cs.ucla.edu 9E23C3C32B0F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.ucla.edu;
	s=9D0B346E-2AEB-11ED-9476-E14B719DCE6C; t=1756837074;
	bh=eScfDWoG65r0IddXZ4PvgQFSYXDLIvRRE5qcVU7f32c=;
	h=Message-ID:Date:MIME-Version:To:From;
	b=YPnPjbf2/e4F6dRkGCetwDUtPGGutr16pVtERnzbbgkoG0VeaCxeEJbV87k0r7HqS
	 Zr/X03QpOi0zT3qEm3cOvOKdooW8u+ABAuOiPnHzoEDKlCWO/hAJ1vOMiMgPoK3pVj
	 V2vsPdk3j27AYzRhTu6Wr+A/GZ34xgMplEO3u6Qd+60UjYBlpCZWBjU6NA8KuL+wWr
	 ocYlaRRK5gAxz9+PRK6Izn5JuED2Xf17f4EsndALmH4/4U/SK5cShnLUaf5L46cd5U
	 M7yZIs8LKLVX4VUkkbTtGI306Umt6/Z+hnHBUYgKae6NMB+ZHhj7SQEb2UfnzMjdGx
	 SkzhBHRP5pQtw==
X-Virus-Scanned: amavis at mail.cs.ucla.edu
Received: from mail.cs.ucla.edu ([127.0.0.1])
 by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavis, port 10026) with ESMTP
 id 33jf8rbRBAcc; Tue,  2 Sep 2025 11:17:54 -0700 (PDT)
Received: from penguin.cs.ucla.edu (47-154-18-19.fdr01.snmn.ca.ip.frontiernet.net [47.154.18.19])
	by mail.cs.ucla.edu (Postfix) with ESMTPSA id 7A1E23C3068E1;
	Tue,  2 Sep 2025 11:17:54 -0700 (PDT)
Message-ID: <bf6cecec-1694-46d2-93d4-0a25128088bf@cs.ucla.edu>
Date: Tue, 2 Sep 2025 11:17:54 -0700
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] linux: Add openat2 (BZ 31664)
To: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
 Arjun Shankar <arjun@redhat.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>, libc-alpha@sourceware.org,
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
 <cbbc9639-0443-4bf8-bbd1-9d3fdcb2fd37@cs.ucla.edu>
 <CAG_osaYc21nR0M3O6UKs8zna6x_k9U4=Rt4B0mKHog=ZLSH1AQ@mail.gmail.com>
 <d88d7228-fabe-41d1-9a09-298fcb313647@cs.ucla.edu>
 <2a979a5e-a78d-4ee1-ac96-7176a8c45fb4@linaro.org>
Content-Language: en-US
From: Paul Eggert <eggert@cs.ucla.edu>
Organization: UCLA Computer Science Department
In-Reply-To: <2a979a5e-a78d-4ee1-ac96-7176a8c45fb4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-09-02 10:11, Adhemerval Zanella Netto wrote:
> if kernel developers are planing to make the argument in/out

I'm not seeing much evidence for such a plan, and if I saw some I'd make 
my feelings known in the appropriate forum. There's no real need there, 
and the only stated proposal would not accomplish its goals.

