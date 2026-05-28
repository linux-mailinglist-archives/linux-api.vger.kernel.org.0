Return-Path: <linux-api+bounces-6447-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEI9FF11GGo8kQgAu9opvQ
	(envelope-from <linux-api+bounces-6447-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 28 May 2026 19:03:25 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 909065F55CE
	for <lists+linux-api@lfdr.de>; Thu, 28 May 2026 19:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77865301F996
	for <lists+linux-api@lfdr.de>; Thu, 28 May 2026 16:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01FA3F8ED3;
	Thu, 28 May 2026 16:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="axxvXFIh"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285433F8891
	for <linux-api@vger.kernel.org>; Thu, 28 May 2026 16:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779987371; cv=none; b=OFRgxAHobfevlqseQBK8UQ4gNOEHraNwHOf+gm2fvocMt4BbVFI77yi7CosjeHDMKm0zJ7ekgTk18SRrXC8qavhNhoy4sviX4iTa4KQStYdvL1Mb4xrF4nzJFZurjC8a9cVTc0DqLjWRlc9XJnMQ1DQXV/y+tvLf7wv+n1gz2s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779987371; c=relaxed/simple;
	bh=dRm6v9rJ98fryRZu+nDZ52gP6ZF+I/symBIWFqheIec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RX5lJs/+93ruxY1NIIpV2/jfs8CzjTWvdZbI8nfxAlqtEzi+a2TatPVyuZAz1sDbtwSUdkQazjDCoR9zj5uuyWYD3uPX4pZV+R/O858Jt/ei7KUpw4ZD6ydUPFPISitwcDUo0+BuGXB2xTqudNfc9Bic7ztPSb/GEM98qEwoX5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=axxvXFIh; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-69de237f0a3so1346621eaf.1
        for <linux-api@vger.kernel.org>; Thu, 28 May 2026 09:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1779987369; x=1780592169; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WDGJeqE4tTfg/YKUkoTVnPS7Lm5TeqY7Toc0BSTB4Ms=;
        b=axxvXFIhScPMwL1SYv1SB/8Twa6Qjpy4MHe4/Zy7f+oNlk8eF6vcpwSjMxUCgkdaZk
         H2r4dgPHHu3jnBszJQpKbqLgekX8xr5tOZIcZbJbYQQIZ8ojEJRLFWpfSn02Vdt590Lj
         +JdTIeluvDz8KhKs9IORim7N+sgGXktxRB1C70gXOxClZT7XoGhKqYzsUg9V7gQMK4UQ
         QlnyMKWM+ISgiaifbHgBHXkboi3nHAgNX4VdKx0gQ4c9QFzxb5Lc246wAjsS2DSZdHMs
         J0fMheyMpMNKb9nzBIxJBG9v1ZmNg2RAwLMqUUokGc6eK8QKKzP0eW7ObVslwpDeP5lb
         H+UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779987369; x=1780592169;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WDGJeqE4tTfg/YKUkoTVnPS7Lm5TeqY7Toc0BSTB4Ms=;
        b=EaWKv7Gh1ti511w5faa1FF2S6HLKeUudQURYWLmZSQnCEQ/kLD9gdYx9SbpHzk+Itw
         ZF/pHbv7vABrTZ9FtG0w1qY9X3ypPF3i6Q21Sb1HxNfUNQiMNcyVE++xa7WKGJBbMU1f
         gsgYcRDuIB3UuHthhBWBW0v6i5lFG2YxQYCNlW/BIhZaNCdIX38JEtyx59C6IVZa8bOT
         Xy1+Dk6qG68+kCotNaN/2byv02cuCDtLSoIYNQv6Zg7WWU0FY4jL5uaKUGgiOg80QfgV
         UpfibSmTDt/Qte8K3cVjCwH+1D32N/sF5n0TBdy8rQR1Eu8/WmfFPDkr8cHZrf5FNQbx
         trqw==
X-Forwarded-Encrypted: i=1; AFNElJ9ipoumvrg9bXgh5ULHsBz9Fnq6zUtfb4bExE789jhqdqOZSe2BD64r6adZ0+u5dYeEZQjtiB5PiEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxMUWSXx/umWD97dSHDf05KbdtM/xFQ4QBOKBOrWeWFcoIZCFZ
	w0n9Rm8YtUmJTJsi3/WvnRXfy4IvxGRYe8StYno6nN9zm2WS7tvdG0ehiM0+nqxx0d4=
X-Gm-Gg: Acq92OECp+e4ZvaZDTOy92MG7Tx6QijUwe+hx0BFtWIsFaRsyQRKoe7X4O+5phwJcVW
	1d/u6OqhBbJRIHVb7+hy8FEZBJRH455x+EWkMImnDyera7tqiT/LwnPFx9N0G5zi2S3paEPteXO
	58GyCXfCdQvTH2sEYvcSSOTAITvXmdSAfSFvCmWTVbJ8/c40eI/z4XXD/LRK4Z2YWTXZLeuLyDN
	A9Cl/CilwjCFhxePwKlIFQuupTVvUtj/PfmcFdxNQt8kmGSpMBvLgCDfqzoNmMS6MlQfx7E7HM6
	ziDld5T7cHb4HxzGKqesSvDTVRB36TkP5Qj9Cg1Vi+uCR5SzBDc4v3Cx7oRqjVQsqlssGa7WVnq
	lI4x8yPClkns+yaRkCWO8AxvfJ7noFW+KSQgXO7qc1v7r9xjF2Jfmzk2IXaMVcKodiP+nLHQPNk
	okvCW7835WeisAf7xonIgE7QYKE/JvmpMdAWe7JtJcSiXo3+hjLfXTxS0RFFdgW9oHygBbobsqB
	B6u52Rxi016X0HPJnA=
X-Received: by 2002:a05:6820:4c07:b0:69b:5fcb:1a69 with SMTP id 006d021491bc7-69d7ed105b6mr14873551eaf.59.1779987369074;
        Thu, 28 May 2026 09:56:09 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69e010cd4casm152656eaf.7.2026.05.28.09.56.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2026 09:56:08 -0700 (PDT)
Message-ID: <2cfd6455-7b5b-4974-b8a1-4a0abca69768@kernel.dk>
Date: Thu, 28 May 2026 10:56:06 -0600
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] net: Remove support for AIO on sockets
To: Christoph Hellwig <hch@infradead.org>
Cc: demiobenour@gmail.com, Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemb@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Eric Biggers <ebiggers@google.com>,
 Ard Biesheuvel <ardb@kernel.org>, linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
 netdev@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-doc@vger.kernel.org, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
 <toke@toke.dk>, linux-api@vger.kernel.org,
 David Howells <dhowells@redhat.com>
References: <20260523-af-alg-harden-v1-0-c76755c3a5c5@gmail.com>
 <20260523-af-alg-harden-v1-1-c76755c3a5c5@gmail.com>
 <ahQCZQNoyO8GQt3H@infradead.org>
 <92db3ff0-8f0b-4b61-a167-5004ffcf9025@kernel.dk>
 <ahanjVfIDlCmeCUE@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ahanjVfIDlCmeCUE@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-6447-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,gondor.apana.org.au,davemloft.net,google.com,redhat.com,kernel.org,infradead.org,arm.com,linux.intel.com,intel.com,linaro.org,lwn.net,linuxfoundation.org,vger.kernel.org,toke.dk];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel-dk.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-api];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,kernel-dk.20251104.gappssmtp.com:dkim,kernel.dk:mid]
X-Rspamd-Queue-Id: 909065F55CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/27/26 2:13 AM, Christoph Hellwig wrote:
> On Tue, May 26, 2026 at 09:58:27AM -0600, Jens Axboe wrote:
>>> The current TCP zerocopy implementation provides completion notification
>>> through the socket error code, which is freaking weird and doesn't
>>> integrate well with either io_uring or in-kernel callers.
>>
>> We already have that via io_uring
> 
> Where?  And how do make that available to in-kernel users like
> storage protocols and network file system, which really suffer from
> the current MSG_SPLICE_PAGES semantics.

For zero copy, on both the receive and send side. Since we have a proper
notification channel, that's what we use rather than the hack that is
the error queue.

>> , and without needing msg_kiocb or the
> 
> What do you think is the downside of using a kiocb here like for
> everything else with async notifications?

Where would the notifications go? You'd end up inventing something new
to propagate them to userspace then. The io_uring side does not rely on
using msg_kiocb, and iirc that part was only ever used for the crypto
stuff and largely broken. Which is why I do agree with just yanking it
out.

-- 
Jens Axboe

