Return-Path: <linux-api+bounces-1722-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 558579055E8
	for <lists+linux-api@lfdr.de>; Wed, 12 Jun 2024 16:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E96B3286126
	for <lists+linux-api@lfdr.de>; Wed, 12 Jun 2024 14:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D082917F4E2;
	Wed, 12 Jun 2024 14:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.ucla.edu header.i=@cs.ucla.edu header.b="DtRonzUh"
X-Original-To: linux-api@vger.kernel.org
Received: from mail.cs.ucla.edu (mail.cs.ucla.edu [131.179.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A49E17DE21;
	Wed, 12 Jun 2024 14:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.179.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718204117; cv=none; b=Ump6tEhWcpdBiC3BloT3lx1KSZUMTU95w3xc9m8RakMHj/+W22zNvFUcyxl4ndik03Dny/uZzwumkwyi0Z8q3ekhBdiBKgNaJ96eOmtzFr1ZfF6rmZDIfBHHuyoh679hbj6y86dHBRbGNlbhTLWD2L+l9BoSxxExhmW3hpx9yDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718204117; c=relaxed/simple;
	bh=m74O2uun32ubD7TVGUT9YowlOg3TDxTfw/QLnMrDV+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IJE3EL1oukD/+6IC1LSwUgALxnOiWj6LG726VGs2ko99ImHa9np4IVN3e+A54Il7WnU6XBzz055o/7W20r0wORGV7M6a0Wvm9MxPHGJ6gS6mVSv6LOR1qcfUc5IMgPvCiL5F15r4L22dNOtP2+0hzM45zxMvhd5q585JFfEpaBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.ucla.edu; spf=pass smtp.mailfrom=cs.ucla.edu; dkim=pass (2048-bit key) header.d=cs.ucla.edu header.i=@cs.ucla.edu header.b=DtRonzUh; arc=none smtp.client-ip=131.179.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.ucla.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.ucla.edu
Received: from localhost (localhost [127.0.0.1])
	by mail.cs.ucla.edu (Postfix) with ESMTP id 707483C011BD4;
	Wed, 12 Jun 2024 07:55:15 -0700 (PDT)
Received: from mail.cs.ucla.edu ([127.0.0.1])
 by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavis, port 10032) with ESMTP
 id dsHmb0yoN7CC; Wed, 12 Jun 2024 07:55:15 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.cs.ucla.edu (Postfix) with ESMTP id 218D43C011BD7;
	Wed, 12 Jun 2024 07:55:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.cs.ucla.edu 218D43C011BD7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.ucla.edu;
	s=9D0B346E-2AEB-11ED-9476-E14B719DCE6C; t=1718204115;
	bh=LF/zdtNmQTMuAyw81ixQy/8LkUn5MOOh7+h6sWGMEkE=;
	h=Message-ID:Date:MIME-Version:To:From;
	b=DtRonzUhytujBlOA/j1x6PBCFgd0gko4As+zJhzAE2zhbKoSXkJuDkd0Qmb1sd+IL
	 AWqmXdQSsEwkp3a9NZGf+dwskPhJ8P3Fv1sqlQQDiCMJUhZ4OLzMqllk+5uC4nRd/W
	 HBOMA4T331SBsuwWdZwxCN6C6pidHeo8v1i9LYi3p8fEgNY2P9EOATONMnBaeCjWtP
	 5yEE95J+m+Cddas64W/4UB9SoQx1oAPGnjL+Rp68+PWlbHMjABD/cpETLwlqwXq1L0
	 vXECjEqxB5lNXDrHreadXvBFUH5stEPqEhVS1RqEhzqkZYrkvmEthpwGwywNWmYOwz
	 HYBJG8b3TBa9Q==
X-Virus-Scanned: amavis at mail.cs.ucla.edu
Received: from mail.cs.ucla.edu ([127.0.0.1])
 by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavis, port 10026) with ESMTP
 id s5tT4BFDb72u; Wed, 12 Jun 2024 07:55:15 -0700 (PDT)
Received: from [192.168.254.12] (unknown [47.154.17.165])
	by mail.cs.ucla.edu (Postfix) with ESMTPSA id ED49C3C011BD4;
	Wed, 12 Jun 2024 07:55:14 -0700 (PDT)
Message-ID: <87af5e8f-0dcb-44a0-94de-757cad7d5ded@cs.ucla.edu>
Date: Wed, 12 Jun 2024 07:55:14 -0700
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: termios constants should be unsigned
To: Alejandro Colomar <alx@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Palmer Dabbelt <palmer@rivosinc.com>, linux-api@vger.kernel.org,
 libc-alpha@sourceware.org, linux-man@vger.kernel.org
References: <a7kfppfptkzvqys6cblwjudlpoghsycjglw57hxe2ywvruzkbd@e6nqpnxgwfnq>
Content-Language: en-US
From: Paul Eggert <eggert@cs.ucla.edu>
Organization: UCLA Computer Science Department
In-Reply-To: <a7kfppfptkzvqys6cblwjudlpoghsycjglw57hxe2ywvruzkbd@e6nqpnxgwfnq>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-06-12 05:16, Alejandro Colomar wrote:
> tcgets.c:53:24:
>   error: implicit conversion changes signedness: 'int' to 'tcflag_t' (aka
>   'unsigned int') [clang-diagnostic-sign-conversion,-warnings-as-errors]

This is a bug in Clang not glibc, and if you're worried about it I 
suggest sending a bug report to the Clang folks about the false positive.

Even GCC's -Wsign-conversion, which is at least smart enough to not warn 
about benign conversions like that, is too often so chatty that it's 
best avoided.

A lot of this stuff is pedanticism that dates back to the bad old days 
when the C standard allowed ones' complement and signed magnitude 
representations of signed integers. Although it can be amusing to worry 
about that possibility (I know I've done it) it's never been a practical 
worry, and even the motivation of pedanticism is going away now that C23 
requires two's complement.

