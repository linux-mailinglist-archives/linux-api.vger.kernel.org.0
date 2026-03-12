Return-Path: <linux-api+bounces-5938-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EDjH7Ups2ksSwAAu9opvQ
	(envelope-from <linux-api+bounces-5938-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 12 Mar 2026 22:01:41 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 274A6279AFD
	for <lists+linux-api@lfdr.de>; Thu, 12 Mar 2026 22:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92E44304C0B5
	for <lists+linux-api@lfdr.de>; Thu, 12 Mar 2026 21:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD0B1DDC28;
	Thu, 12 Mar 2026 21:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YY71qaVz"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C67A2D7804
	for <linux-api@vger.kernel.org>; Thu, 12 Mar 2026 21:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773349291; cv=none; b=b1hm5cd928yFd1ApkHtg4qsiIk2dp4w3P/x6ybFkjKvlrDNXEGAvaDyG+iOKK+v6CEAL3TPDMMBmFuaeOQZl+d6J/eOSMxiey1hHzN58min0aE7vN41fMLHXSk4YjgwuLDe8hnfk4hRb32VTQJhQ2AnwKE/H4C0WyLGnSLfHjxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773349291; c=relaxed/simple;
	bh=2m0TEEdToE0XfmBlxsTZbLjAe5WXrhF8lZof/Tgjw3A=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=X9iUSCio6dOlxcFC3qFJz5l13PLOu8r+TitqRYpemEzaVS+yShcp9LU4iAPrn9MZdvy5pwscAT91pjTlzdVBWTKwcVre6hVU4rFLt0ODmClCPQgZaMYQLbcLP/o/coIfI7DOyCIazX03aZK15EELJl1WtD0vAHY8s3e/MFLhbiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YY71qaVz; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-439b8a3f2bcso1154003f8f.3
        for <linux-api@vger.kernel.org>; Thu, 12 Mar 2026 14:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773349287; x=1773954087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2m0TEEdToE0XfmBlxsTZbLjAe5WXrhF8lZof/Tgjw3A=;
        b=YY71qaVz1Ikyg9nyE+j1p1xLFMUF5CX40C8Bf188Ai9o06NH1OgjglwAuHI2HJ+eKH
         cgUQTg3UCGPWHn6Ym13OoQSfrw6T7X63TKLmYHMTloW0BiwVdvJSLQhjbUck9lxUyLP7
         UFUSwjwQR0xVM3cBqtNYHTi4p+B7wIqArdCNnVzmSMpyEDPebMK97BMSK4yN5rNyIXbr
         b0RRaJ37cFRjXohQwk5c1VxZ7NkLH5Eof1Edhs0Yz8Q7nKZvLg5BYLRw36mwE0qmJjyJ
         +ZOP37kdvywkqMehhmOdS1qVkJ86cNcRoIQ0ueVoKfPalsjn0Ui353RAKySLh0JWg+h5
         LiZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773349287; x=1773954087;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2m0TEEdToE0XfmBlxsTZbLjAe5WXrhF8lZof/Tgjw3A=;
        b=NY4YaHzU1nh2od7qQ7x59Vf61Nvgx7oBLvI4rsPhLMICbTAI2j5B0NmS8M4bAchHXk
         mWiMTCjqQOHRq60JK9GrH8sztlgn33g6zuI/ij/sf9aC9gPfnqkp9ZIhcaZ/Ya7NHFf7
         /Z7tRZQTYMxQbTYXfbjZgle7RB//OhzNUlGeTBdvITGfVnfEsuKcnvpYx/ojSGwHPaNe
         wl6h/HG0tU6x3/wyknMYVaCzXHo9nUErm5mTd3311YJRBByo9njDKx7c7BLK1s/K8hn9
         4QO6ppvVaGpo12gILEIDxbGvvYAwcoif92s5n8FhW8eTfvG2hsGvJ5esGno60jDRzDB3
         sAiA==
X-Gm-Message-State: AOJu0YyM771mWxv4llrbDps1mFkwuio1WcDacB0NlGz2hAEkoFD2MgyQ
	8uXpGm/7UrfNpvu08xCwoM2mKyVVGEjkbTWNkfCi+nqBaCI9SUTQoMJRRheci2S+3RpdeQ==
X-Gm-Gg: ATEYQzwL0EMmgVEM4WaSGZ1WfdPa3IXJzN/tZR/5cUhOye+7JYin9CvlHMcXOFjraSG
	tZVKNappqIyL6ly4UD4dEVPBSLWllxau55eODW2H3bT/jl/qivUSdaJsSFSWRdgHK9vIl0k6yKT
	H63ShffSsjMGrT5RdRPAp9PK2bstV01t/Sf3QwWXISuB6nr3NFexDPDtFOln2UL/sCZnT1Db5F7
	lVFlYlDc1p8uyRnwwz+TsHB6/Bun2NB5xtO/Nudivu5zYHETQwhWR1WtfkVgNXidD2J1eInLxIx
	nODrC8PfbhRmfUOwLs0pcSpq/QCDuoyCdyWNWQakPkP9V0CE+iaDQUKvodyan/Afx8FAV7pMjom
	BvRRYtkeClyDdgFH2nOXeoXk6I55LTgtW5dOoZVf3I5QUGQJ3vzGv/tOHO08VVGPzsFu2Q6WwaE
	p7R7gfgIPQhc6ASiMbJ51QlbcKNnoWwSbnhRMK5bSh0aaYZ1ZPRfb3xVC9Wv9/NJpcLUPKZ/c+3
	lG+X3qZ9vAzYwoCQXA=
X-Received: by 2002:a05:6000:220e:b0:439:b541:a088 with SMTP id ffacd0b85a97d-43a04dc8654mr1897210f8f.54.1773349287324;
        Thu, 12 Mar 2026 14:01:27 -0700 (PDT)
Received: from [192.168.1.14] (mm-214-205-122-178.mgts.dynamic.pppoe.byfly.by. [178.122.205.214])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe22f3a4sm11813928f8f.38.2026.03.12.14.01.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 14:01:26 -0700 (PDT)
Message-ID: <660c10e6-f8b5-46e2-a424-e3e052992b3a@gmail.com>
Date: Fri, 13 Mar 2026 00:01:25 +0300
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Roman Bakshansky <bakshansky.lists@gmail.com>
Subject: [RFC] Modernizing Linux authentication logs (lastlog, btmp, utmp,
 wtmp) with SQLite
To: linux-api@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, audit@vger.kernel.org,
 libc-alpha@sourceware.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5938-lists,linux-api=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bakshanskylists@gmail.com,linux-api@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[linux-api];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 274A6279AFD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi all,

I'd like to share a draft RFC proposing a complete overhaul of the legacy
binary logs used for authentication auditing in Linux: lastlog, btmp, utmp,
and wtmp.

These files, designed decades ago, are running into fundamental limitations:

- Y2038 problem - they use 32-bit timestamps (time_t in lastlog,
   tv_sec in utmpx). Even on 64-bit systems the fields remain 32-bit
   due to ABI constraints, so all Linux systems are affected.
- No extensibility - any new field (e.g., container ID, service name,
   source IP) requires changing fixed structures, breaking all existing
   tools that read them.
- Poor query performance - tools like last, lastb, who have to
   scan whole files linearly; with millions of records this becomes
   painfully slow.
- No atomicity - partial writes during a crash can corrupt logs.
- Concurrency bottlenecks - multiple writers (sshd, login, etc.)
   contend for the same file with coarse locking.

To address this once and for all, the RFC proposes replacing these logs
with dedicated shared libraries that use SQLite as the storage backend:

- liblastlog2 - last login time
- libbtmp2    - failed login attempts
- libutmp2    - current sessions
- libwtmp2    - login/logout history

SQLite brings:
- 64-bit time -> Y2038 solved forever.
- Indexes -> O(log N) queries instead of full scans.
- Extensible schema -> new fields can be added without breaking old tools.
- ACID and WAL mode -> atomic writes and concurrent access.
- Portability - runs on any Linux system, no systemd dependency.

The full RFC, including preliminary database schemas and API drafts,
is available in the discussion repository:

     https://github.com/bakshansky/linux-auth-logs

I'm looking for feedback on the overall direction, the proposed
interfaces, and the open questions listed in the document (e.g.,
library naming, database location, fallback options for embedded
systems). Please use GitHub Issues for comments, or reply to this
thread - I'll monitor both.

Thanks for your time and input!


