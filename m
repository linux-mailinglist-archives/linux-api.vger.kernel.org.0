Return-Path: <linux-api+bounces-5964-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAOZCldStGk4kAAAu9opvQ
	(envelope-from <linux-api+bounces-5964-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 13 Mar 2026 19:07:19 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF58288811
	for <lists+linux-api@lfdr.de>; Fri, 13 Mar 2026 19:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BFDB30D1336
	for <lists+linux-api@lfdr.de>; Fri, 13 Mar 2026 18:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B96E3DA7E6;
	Fri, 13 Mar 2026 18:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mWdZxpOS"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7522D2381
	for <linux-api@vger.kernel.org>; Fri, 13 Mar 2026 18:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773425026; cv=none; b=NpslCtvs1V+gbzHsV+jx8vffqYq7vRKM9aA+JsOpLo3L9drGV7uyElYyHWq4KXnMUgHNojVfitMnqWmb69AiHzTE8K6LlG5lL+b7mkZ941884DHcDhixmdnlmpiT1Gyyba1JRFkyqQXSTZTiRDcsFqN9FuG8aeSJQWSKhcgkAl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773425026; c=relaxed/simple;
	bh=Vw53QYHKCbG3i2bjJKJQ7E1adE09hd57m/qLrHD7O6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eekVJiIaHIGkRQRu2vP3s+p0F+XYaSD+3Ru7ZLZmumrn9MZK8tsA8U6V5b8XOodQal/IXcYSb+L+qhrRj+eXen/nFijFh7xQhftng+VXyu3NJGLW+5xa/SzXBfOPRJDslcGtF+2JF/igkC9e3ZxuF8nVy8BQF3jwQclwTlHbKV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mWdZxpOS; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-128b9b7e3edso3655177c88.0
        for <linux-api@vger.kernel.org>; Fri, 13 Mar 2026 11:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773425025; x=1774029825; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PSOEv1xERLgXH2ZBdcqMBoKy0zuIxCKcPMy4xL8vk84=;
        b=mWdZxpOSWxtpK8upexkeRRp1Tj4uXKlnfgSalwu40eQRl4fr+6O9jFnQrIbBcG86mo
         tDIC6wppEDWvo8E9AZP5HYrNHFVt8w2YjNIe8PfUoYiRMoywZWsJ/FwTMOqJC+94/K92
         5DCvynQKXQLr0ND9XM7bba1W5f14doEOgvV8sBpBAVdAuKUesCf/3yD7j2Gzv61sPDfc
         vEVzwtXltNLcpDlmacLv2guX3Avea8VgyAX3FVAqEyDQFRPUy03sUs+yKXosO0VBV6W/
         8pZ9YRB8DLri6emjsSQyS0SapiSywMli2LdgZcr+TdcPJk88pNcfc6Q3lYXdp61QS8s9
         2Yzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773425025; x=1774029825;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PSOEv1xERLgXH2ZBdcqMBoKy0zuIxCKcPMy4xL8vk84=;
        b=kB8PmdIM9LSGYeuj53pBvBhuzmE1qGWOzvZahEqgFjNTcHcLnJ9Mx4qUAYip7WJ167
         vJaxB8uCHJzsCRCRYn9Sj6Uu7by7bfqU8IfY/5MH+tXcu1fLox1EWcjcMFCYlk0d/s33
         HIf2olq0JIhRWTx+8ZRlwv432xRYJ/2pY6BHfs9AlxvGQu89zJW1XQKuvjKkBmLFQWWY
         uMZ+c/4DZ4oS11qOtJdcPw7nA9D9oKXURv1gXVQk49CF+NOuU/qjrTxW0/7Ib/lSiSCp
         2CUYeAXOiMOu3FUbIopvfvLQDsHsTCkx/nWEI8OhTS8f9Vmc7ZcCxWkyUXwxZ0RJc/LN
         egkA==
X-Forwarded-Encrypted: i=1; AJvYcCV+0so5zm+oLBsngrsb3XvkqoxMjTyVhfN0B+AuVj4NIBt2KLEdC4KCM91+AKr8fZUsNDjSF86M1hY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFOWxGOWwoiMzLkH1Ot+AxJnqnBBYSRl0k/Fk+Xr+Xn/qLlirJ
	xkYgUUK159T1HC8lymOmOG1UxtAxeQeMWV2ts2/QVsFz+beqSifi2C1Ff6+b23x4NSzGTp/cd14
	Dkiel
X-Gm-Gg: ATEYQzzY5HyU73ohKhqC9ztlLSsqkasbWgaLkWqdSbbf2tB5pMDIuOMDbvVwFZkU/X9
	lYve2H1g1VtiKjcuL68bPW5c9y1F8U4TESNY9H/4cHqS3yApMxX2am+2Uf8l2I/RjZ9atb/Rn8p
	IjsVQ7n/+P0N4mM6n2yiKUOU9TE1iDKVQXO9jt2BcsgfcsmHFTVdB3qqhmbTahRtGiO+n+tI1+P
	J64w0eSZayoup2VzcHYRovSEYJQ/7uehFnL4YDvK0VHbKoLR5HLZmDYzyP1mfW8dKWc7GrgElXX
	EAL6HDZ3BWfARU/c4x1fFUkZh/HFDR24Je/Qdm3bf3R8gpCYVTGSFHFjy7Up54KowZAfGf7iwqM
	a8eZVy+MPEwmFs7lAMY7jWebImF31w0Olr5v13c0TffTKp2zEHH9eTUDAKml21pS5ATHi2gH/Si
	QHl+kG53gWGXskwuKEwsFOqIL01XZzNnUCYeiiUjXvnM1JOx5eMu0dTQ79jbNJtBLGs2gXHBnCD
	gBtT0yBZX/49eUmcIZ07cVkB4nfqjA=
X-Received: by 2002:a05:7300:72c9:b0:2be:8216:57d2 with SMTP id 5a478bee46e88-2bea5442cd0mr2235815eec.9.1773425024417;
        Fri, 13 Mar 2026 11:03:44 -0700 (PDT)
Received: from ?IPV6:2804:1b3:a7c0:49c8:a562:e69:d236:fd56? ([2804:1b3:a7c0:49c8:a562:e69:d236:fd56])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2beab526f9asm4197038eec.19.2026.03.13.11.03.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2026 11:03:44 -0700 (PDT)
Message-ID: <33904ff8-c018-4464-8876-ec8035e14b05@linaro.org>
Date: Fri, 13 Mar 2026 15:03:39 -0300
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Modernizing Linux authentication logs (lastlog, btmp, utmp,
 wtmp) with SQLite
To: Roman Bakshansky <bakshansky.lists@gmail.com>, linux-api@vger.kernel.org,
 Thorsten Kukuk <kukuk@suse.com>
Cc: linux-kernel@vger.kernel.org, audit@vger.kernel.org,
 libc-alpha@sourceware.org
References: <660c10e6-f8b5-46e2-a424-e3e052992b3a@gmail.com>
 <2d5de14a-17d2-4d08-992e-cbc5d430e231@linaro.org>
 <948e83d4-4a34-41d5-a394-6c4ec17bc534@gmail.com>
Content-Language: en-US
From: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>
Organization: Linaro
In-Reply-To: <948e83d4-4a34-41d5-a394-6c4ec17bc534@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5964-lists,linux-api=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,suse.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adhemerval.zanella@linaro.org,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-api];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,thkukuk.de:url,sourceware.org:url,linaro.org:dkim,linaro.org:mid,openwall.com:url]
X-Rspamd-Queue-Id: 7EF58288811
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 13/03/26 14:48, Roman Bakshansky wrote:
> On 3/13/26 4:59 PM, Adhemerval Zanella Netto wrote:
>>  From the glibc standpoint my plan is just to make the accounting database
>> function no-op [1] (I hopefully to get this in the next 2.44 release).
>>
>> And I think Thorsten Kukuk already adapted most of the usages in current
>> distros [2][3] using similar strategy, along with a better systemd
>> integration.  I am not sure if/when distros are incorporating his work.
>>
>> [1] https://patchwork.sourceware.org/project/glibc/list/?series=37271
>> [2] https://www.thkukuk.de/blog/Y2038_glibc_lastlog_64bit/
>> [3] https://www.thkukuk.de/blog/Y2038_glibc_utmp_64bit/
> Thank you for the links and information.
> 
> I have been following Thorsten Kukuk's work. I know that liblastlog2 is already integrated into util-linux and successfully solves the Y2038 problem for lastlog. I am also aware of his wtmpdb project. These are important steps in the right direction.
> 
> My RFC proposes to go further and provide a unified solution for all four files: lastlog, btmp, utmp, wtmp. The idea is to create a set of public libraries (liblastlog2, libbtmp2, libutmp2, libwtmp2) with a consistent C interface, built on SQLite. This would provide 64-bit timestamps, indexes for fast queries, ACID transactions, and schema extensibility without breaking backward compatibility.

I think you will need to check with the systemd developers whether they are 
willing to integrate this idea into their plans (if they haven't already). I 
recall that systemd is extensive in some form.  My understanding is that 
eventually all distros, at least the ones that are systemd-based, will use 
the systemd-provided framework instead of relying on different libraries.

From the glibc standpoint, providing this was always problematic, and I 
shared Rich's view (musl creator) that the interface is insecure and legacy [1]. 
 If I were to implement something not systemd-based, I would follow the 
direction that utmps used[2]: a daemon as the only authority to handle the 
files and all clients (utmp{x}.h} uses will just query through IPC.

It means that users should not care whether how or where the database is 
placed (the _PATH_UTM and related macro should be handled as legacy and 
deprecated), and the client should only care about the record structure 
in the usual C form, along with a version (so no extra concepts on how the 
record is placed in the file).

But I wouldn't put any extra effort into a different API as you did; rather, 
I'd check how to adapt legacy programs to work better with systemd. These 
interfaces are really legacy, and I think we should move away from them.

[1] https://www.openwall.com/lists/musl/2012/03/04/4
[2] https://skarnet.org/software/utmps/



