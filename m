Return-Path: <linux-api+bounces-5940-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4ADLF8QatGlLhQAAu9opvQ
	(envelope-from <linux-api+bounces-5940-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 13 Mar 2026 15:10:12 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D745F28499E
	for <lists+linux-api@lfdr.de>; Fri, 13 Mar 2026 15:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B257431A9831
	for <lists+linux-api@lfdr.de>; Fri, 13 Mar 2026 13:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A3F38D010;
	Fri, 13 Mar 2026 13:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FhtvxNdH"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF404264614
	for <linux-api@vger.kernel.org>; Fri, 13 Mar 2026 13:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773410359; cv=none; b=q32bMWtOZLevjjU4LBWhQ76V4UQuy4qfQkgETYX7XplWWMbDQ1OUqGIrCIhqVXLo6yTd+kRT3fbA9WERLRNyWSOmn7nlBrmJfwLPY7vgmh4uWZ5ls1G4pjJi33XOnLCBrWIIijFcb3+FHgEqCVPkta7BGWvrsKCLQUqcljQCv6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773410359; c=relaxed/simple;
	bh=G/2GudsY16WgckOKKpfCxUlxP4/qeV6zEYS3Nvez+uk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CM4/VcaHlpO/VGTZrKuZpExmzxOJ7JXWBrDGezy7+94A+lIEn4lV0WS0iPoMbaIjSkkgDtWVXidZbWk6wNki+B94HoA/SksL4fm6eAXpXZctCP/P3GYHDNFJp9fw6/MSJPv9m2rKzKzgi4PsyeJ1Kzk1rof3VctJoc5u2rm8FXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FhtvxNdH; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-127380532eeso2490202c88.1
        for <linux-api@vger.kernel.org>; Fri, 13 Mar 2026 06:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773410357; x=1774015157; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jkQxYDJ/fqj9oY7QWpa/xMQehKB5EfjV0laBIMwYETk=;
        b=FhtvxNdHdQQUMoluj48dS4qncQ8Ga937qqCYBIH3lR5C4u4neBazdQy2RX3gnQn4fd
         uihMazCPWX95obOgk4XWsCCQriE/71MokVt5aafuXhejlg8z5sbcP2x+kTCV5akrxpFL
         c55tKc5AKqxw5CMnsHJx+QmB78GjD41MulAOMFs4tsZLwOI8U8Ibh4qV1AdBaoOjTt46
         5hiAtRQzsSNXuay2ABZibkID0u5+UBgubBE9nlyvye7bTksiorIIXTlWJpvlRtp5jvlw
         W9seW8CNb1iQKiU5UqXjiFcszriZIT07JXuH4jaeSFc30+9td7/+23fJ8MMY7Edhnt9z
         5OjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773410357; x=1774015157;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jkQxYDJ/fqj9oY7QWpa/xMQehKB5EfjV0laBIMwYETk=;
        b=OqBiZbx8VS2+7zT6HVgxJneooYOgHJc6znupm0zXo5OrwCDX08YHevHldtidFSCjMX
         P8o2P17FLsCfZBWiCYl1jIAtSLI4nl3GL/lqSp93UjMu95VL8VY1ZWH+8Tcy9jImaV4h
         ap/fh0uG4O8MqyvEE47ePAzeBI7jUkrigO7BUK5pfCFavs8un81D5mt52LS+kDiLEFy3
         gOuoM6j55q2AAfoZpFnSb3EXbFOAcPzUAGtjcM4UhwYOKoPR8RMWfgV2iCsIcJFt/3uL
         oegLB1jwOlfRgzzwpFvz3cTmt3IsyKhlbEY0WePqiDN+6Fpnxni8oXlNv8XXxR9J+ANl
         8ing==
X-Forwarded-Encrypted: i=1; AJvYcCWYfMZJ5Q2YQrgx2LljnJcrfmDX8jAH4kzUZrzp9P/WI/99yKAuKlkZNXnHhFQKPyDEw2vTASnBllI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzW3tFmagHXUOxNowuxjYGCayW4qUMyFHK2JG9yVgWkWQZsiFJ
	UuuKtRA06Wi+eoDP+aD2P0F/v3TgByhCBSP7AxJSxq0PK9JFOmqJ5bQBxyOjDYO6y88=
X-Gm-Gg: ATEYQzxJ2NPGAwek1/HVnHWpx1PHEsg/QyWU0KrlVleJbP7rACp6IeP6eGj9CJKG8jQ
	7g7J1ieHjZJuVBIY3bfchQn9h4u7s1r0e/+Bqhk1mQMYghsafE9Dtxjwoz18DPpECbYC1LKGp4z
	VaJk1bfELKiEDR6LdyAEkUGMYda/b+tyUFK53SzqqYF51Sn1Gfg4ItVTQbZkvD8pDdEWyttxe4a
	fb62YvYR1/4quMFkY1KoO0pJCdyDEgMWymFGiLlcxeIzaVXHacxvUtnKZhMp/wU4fZ9UFtyxX6g
	kT7gjurJkE+zNY0FvY1smvt1n1zOo3VaSiec3EhUNwZeDlPYWaQPPz0weIcNi2EEr/C0/QtYV9W
	d3ReWkTAgGUf6tUQsVf94Nix9GXK5aUO7SlRCzsGT2FHuqrx18xSxgLsEOJzwZ8PRi8fPtzSFVQ
	iqLZ9l81mDZE1ZnIC49CV4aJso9HjaIQrG/EVT7eQj8xhME3qp3l7KueIP4tYDScbKrUl1oPWhN
	2eEOri9Fg5FNUWYV+5yLvwGr+TIbjo=
X-Received: by 2002:a05:7022:6283:b0:122:153:d161 with SMTP id a92af1059eb24-128f3d7b662mr1856388c88.17.1773410356653;
        Fri, 13 Mar 2026 06:59:16 -0700 (PDT)
Received: from ?IPV6:2804:1b3:a7c0:49c8:a562:e69:d236:fd56? ([2804:1b3:a7c0:49c8:a562:e69:d236:fd56])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128f63baa3dsm2417528c88.15.2026.03.13.06.59.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2026 06:59:15 -0700 (PDT)
Message-ID: <2d5de14a-17d2-4d08-992e-cbc5d430e231@linaro.org>
Date: Fri, 13 Mar 2026 10:59:11 -0300
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
Content-Language: en-US
From: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>
Organization: Linaro
In-Reply-To: <660c10e6-f8b5-46e2-a424-e3e052992b3a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5940-lists,linux-api=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,suse.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linaro.org:dkim,linaro.org:mid,thkukuk.de:url,sourceware.org:url]
X-Rspamd-Queue-Id: D745F28499E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 12/03/26 18:01, Roman Bakshansky wrote:
> Hi all,
> 
> I'd like to share a draft RFC proposing a complete overhaul of the legacy
> binary logs used for authentication auditing in Linux: lastlog, btmp, utmp,
> and wtmp.
> 
> These files, designed decades ago, are running into fundamental limitations:
> 
> - Y2038 problem - they use 32-bit timestamps (time_t in lastlog,
>   tv_sec in utmpx). Even on 64-bit systems the fields remain 32-bit
>   due to ABI constraints, so all Linux systems are affected.
> - No extensibility - any new field (e.g., container ID, service name,
>   source IP) requires changing fixed structures, breaking all existing
>   tools that read them.
> - Poor query performance - tools like last, lastb, who have to
>   scan whole files linearly; with millions of records this becomes
>   painfully slow.
> - No atomicity - partial writes during a crash can corrupt logs.
> - Concurrency bottlenecks - multiple writers (sshd, login, etc.)
>   contend for the same file with coarse locking.
> 
> To address this once and for all, the RFC proposes replacing these logs
> with dedicated shared libraries that use SQLite as the storage backend:
> 
> - liblastlog2 - last login time
> - libbtmp2    - failed login attempts
> - libutmp2    - current sessions
> - libwtmp2    - login/logout history
> 
> SQLite brings:
> - 64-bit time -> Y2038 solved forever.
> - Indexes -> O(log N) queries instead of full scans.
> - Extensible schema -> new fields can be added without breaking old tools.
> - ACID and WAL mode -> atomic writes and concurrent access.
> - Portability - runs on any Linux system, no systemd dependency.
> 
> The full RFC, including preliminary database schemas and API drafts,
> is available in the discussion repository:
> 
>     https://github.com/bakshansky/linux-auth-logs
> 
> I'm looking for feedback on the overall direction, the proposed
> interfaces, and the open questions listed in the document (e.g.,
> library naming, database location, fallback options for embedded
> systems). Please use GitHub Issues for comments, or reply to this
> thread - I'll monitor both.
> 
> Thanks for your time and input!

From the glibc standpoint my plan is just to make the accounting database
function no-op [1] (I hopefully to get this in the next 2.44 release).

And I think Thorsten Kukuk already adapted most of the usages in current
distros [2][3] using similar strategy, along with a better systemd
integration.  I am not sure if/when distros are incorporating his work.

[1] https://patchwork.sourceware.org/project/glibc/list/?series=37271
[2] https://www.thkukuk.de/blog/Y2038_glibc_lastlog_64bit/
[3] https://www.thkukuk.de/blog/Y2038_glibc_utmp_64bit/


