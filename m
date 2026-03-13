Return-Path: <linux-api+bounces-5962-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SA+FMvlNtGk4kAAAu9opvQ
	(envelope-from <linux-api+bounces-5962-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 13 Mar 2026 18:48:41 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9CD2884BF
	for <lists+linux-api@lfdr.de>; Fri, 13 Mar 2026 18:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 59572301FBB7
	for <lists+linux-api@lfdr.de>; Fri, 13 Mar 2026 17:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2AC3D090F;
	Fri, 13 Mar 2026 17:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQk98tOQ"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0FF3D0901
	for <linux-api@vger.kernel.org>; Fri, 13 Mar 2026 17:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773424110; cv=none; b=adfqUO5roH7vQfuY2uCnBMR8/cuDo7AS9qIZ1QVwc3xSu6KajaRvTZxPuieZhiFr+SapordEJ93e6/mn0Z0nzNxGs3NUfbgvb/uzPg5p0BoumVr9nKeG8TKyz+H/3x6SQUNjzKO+V3i5xdor+20pT6GmWGUvlW5WTaNK43XY+PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773424110; c=relaxed/simple;
	bh=TWDo8QSGG9FgM5eDtpe6obe0bpwVrY9XvgV6/9CBZdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IlikdT+s/OboF+VsOA1ANF2gtjn25qCSx4ZTxA93L1wKPnrVENyF8JCcc1uaeUa1YcvwwoXPWvzWmSuv8IAU+5BeK7saY+4hAVd3KDhiKjV/gOcOXedry3VJd+BnarYz/W206SUo+aW2C2Igcn66IV6b5FUhY+yKWIolSHfQhQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQk98tOQ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48534237460so26802445e9.3
        for <linux-api@vger.kernel.org>; Fri, 13 Mar 2026 10:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773424108; x=1774028908; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4wc59JHWlxlV49Xu4pkv5qxkwv3LnMLE9wiNeBvnGno=;
        b=YQk98tOQqO/SbCBjm2l2d0IYEjkkmtoO+3qmHdQPhMd2hy4c7T5jzhYgXwrpsiAVF/
         UwgJJhm/OvURZMRrvVs2ymk0fMO33jd0YjFI+pQ8XUoIQthJemiSA1kKLgnervl5iKlJ
         pn5roA+T+W/O0GPJ1qcKOmpDbe+KdmgSZ00HOCIuH7nUZjqZjPu4SdbAOIi4+0YC4Z6T
         sUr1Zf9u0DM0yUZR2sgRsTEmeZM4eTzHsuWhOaWiT6XogCOswQjRyDprHYPjtvDZ4jbP
         R0GgCinx7ZmrjRPNm8Y6ADXnf9x0UILkk6Nad7vuA052tBLZMhEyssn87nfAvb7uYkri
         yJHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773424108; x=1774028908;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4wc59JHWlxlV49Xu4pkv5qxkwv3LnMLE9wiNeBvnGno=;
        b=YGxdsu36xVLhe4o7ME54ttiqYZlItt48q8Kc3jnjoG/Iiz/ArhDLaxUy6go4jL9gae
         NhxNpcFv2CubbQ3X7tf3VH4sgQ0FjCEnSFQ1VlDcvfC8gYIwgNUaL6YLO5IPjb9joKtD
         OhGW5nmHPk8ZucaKvZ9nbeEAil9wj94QN2R3SXnswVvbqUgQCUf4R4GufLTCYcwPPlsH
         U22cRI/Bt4bLhJnR64Sg2Gp9ONh9hIjQalVMigN6UMIyCuINL4mEtSnzT9dYfrdKfHfp
         MQKXMTi5dwRYmOLBdQu0AmRjfA8I2r+WD6J3/fcoycPlsm0Dnru4IkK00whYCi0c9Uj/
         xkSg==
X-Forwarded-Encrypted: i=1; AJvYcCVvEaMpx7gt6VUG2Sc+GvIPJTAtFwuxWmJQm0rDLEafkrPhRa5BL1cqjyJu9G+SYlkPVpClpUYZCIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKB8QasAzRaviF/zINagX1Q3zX+DQlqjm5J1CeEJjkjfNRmv4e
	40120tiSbfKtRbcAReD6JSFcIRdNWxN/2WWCQ1yMVLWJJeNSd7SmXO7hEsTFcYdE6xu1+w==
X-Gm-Gg: ATEYQzwyq11Vx8scIuDgYTJij4pu6rYVp3VD/DBkdiBIqkhHihoaSs6HkBFMKM6FsfX
	fS8i4tCOCjX6f/kErmypK54SW1o4KV4HxxNbdg+l+u6RcavCRPpGwNLU+PreKLT5gh9i5uyexDT
	xM+bIouu4Yjcyc7fGFsYVthXfb6H8vOLFk9+gA8/dFMVMJ8kfe4gXCSEC6cS0rNS5BbB+RtjDVV
	fH9JZoTJ0kBRUsBiGIRXcUZGpCAeQZ1i8TjEHDuLUtkiGj+gO3Q+CtSwfbxoD0+j4ujqTbuvSuU
	RCbrUVsVSMsvx9iiVc5mcLRPqZbykhipINEEVzf+QOIBCVZtgY7vW3UlwjLes5jMpExN9Kh/zUQ
	q0+Hvd82gBD6r9uEHvY39qcVFDXizYZDJleJQ2RI0YzbIdUqLZapeCh/4WbSBka/rZTqguf3zt0
	ElpzzLmK3/oqJg6fsezUrINowcI7ib643sWeg61P7BHoIvnetpzuAOKjNFEZEBdDdYgOTbRw6ir
	W3FkA7wa/StkAYjLSU=
X-Received: by 2002:a05:600c:37cc:b0:485:5812:27bc with SMTP id 5b1f17b1804b1-48558122839mr56882655e9.5.1773424107565;
        Fri, 13 Mar 2026 10:48:27 -0700 (PDT)
Received: from [192.168.1.14] (mm-214-205-122-178.mgts.dynamic.pppoe.byfly.by. [178.122.205.214])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b66e3f8sm217631535e9.14.2026.03.13.10.48.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2026 10:48:27 -0700 (PDT)
Message-ID: <948e83d4-4a34-41d5-a394-6c4ec17bc534@gmail.com>
Date: Fri, 13 Mar 2026 20:48:25 +0300
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Modernizing Linux authentication logs (lastlog, btmp, utmp,
 wtmp) with SQLite
To: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
 linux-api@vger.kernel.org, Thorsten Kukuk <kukuk@suse.com>
Cc: linux-kernel@vger.kernel.org, audit@vger.kernel.org,
 libc-alpha@sourceware.org
References: <660c10e6-f8b5-46e2-a424-e3e052992b3a@gmail.com>
 <2d5de14a-17d2-4d08-992e-cbc5d430e231@linaro.org>
Content-Language: en-US
From: Roman Bakshansky <bakshansky.lists@gmail.com>
In-Reply-To: <2d5de14a-17d2-4d08-992e-cbc5d430e231@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5962-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bakshanskylists@gmail.com,linux-api@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-api];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sourceware.org:url]
X-Rspamd-Queue-Id: 7E9CD2884BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/13/26 4:59 PM, Adhemerval Zanella Netto wrote:
>  From the glibc standpoint my plan is just to make the accounting database
> function no-op [1] (I hopefully to get this in the next 2.44 release).
>
> And I think Thorsten Kukuk already adapted most of the usages in current
> distros [2][3] using similar strategy, along with a better systemd
> integration.  I am not sure if/when distros are incorporating his work.
>
> [1] https://patchwork.sourceware.org/project/glibc/list/?series=37271
> [2] https://www.thkukuk.de/blog/Y2038_glibc_lastlog_64bit/
> [3] https://www.thkukuk.de/blog/Y2038_glibc_utmp_64bit/
Thank you for the links and information.

I have been following Thorsten Kukuk's work. I know that liblastlog2 is 
already integrated into util-linux and successfully solves the Y2038 
problem for lastlog. I am also aware of his wtmpdb project. These are 
important steps in the right direction.

My RFC proposes to go further and provide a unified solution for all 
four files: lastlog, btmp, utmp, wtmp. The idea is to create a set of 
public libraries (liblastlog2, libbtmp2, libutmp2, libwtmp2) with a 
consistent C interface, built on SQLite. This would provide 64-bit 
timestamps, indexes for fast queries, ACID transactions, and schema 
extensibility without breaking backward compatibility.

