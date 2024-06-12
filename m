Return-Path: <linux-api+bounces-1729-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D35F905AD2
	for <lists+linux-api@lfdr.de>; Wed, 12 Jun 2024 20:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23F161F241D2
	for <lists+linux-api@lfdr.de>; Wed, 12 Jun 2024 18:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75793F8F7;
	Wed, 12 Jun 2024 18:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.ucla.edu header.i=@cs.ucla.edu header.b="qofVBHOb"
X-Original-To: linux-api@vger.kernel.org
Received: from mail.cs.ucla.edu (mail.cs.ucla.edu [131.179.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8BC31A83;
	Wed, 12 Jun 2024 18:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.179.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718216831; cv=none; b=gOqSvWiWKnEmH0yBBGNL3Ml+PqN3SOQES+CQetD5Nx8pxr5vQKA3DGkcw7+M8OqtDJagl/eXQn3MBW+zuUwVgANZIwviQ7tziENnt8cF4gZmbNBLg3MMkIrBzG6QIzBCMufvkv2MXo1PdKqz2Gfai1Y1k1pQyJOYvFMQkNS06aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718216831; c=relaxed/simple;
	bh=XE4JTqeoVLnlJ6PVxaKlwMbi6ErfvMvSBlZy2m8gMzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V1AyLY28fS8OxnLHwxJ50PNtaFygJk2ZHmVBaLJdu7IylsZDZwxZLAqGKiYPT/Mg4PMdAlV44rWdhMc1aGuLPFMTkJxJ8yLgMrSTk+GncbySn/PCCDwnrEZkk7UUGrDlD0v2mz8Ru0RAoRUHYMV7O3CQ0XJBmOs7SvES0RusqYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.ucla.edu; spf=pass smtp.mailfrom=cs.ucla.edu; dkim=pass (2048-bit key) header.d=cs.ucla.edu header.i=@cs.ucla.edu header.b=qofVBHOb; arc=none smtp.client-ip=131.179.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.ucla.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.ucla.edu
Received: from localhost (localhost [127.0.0.1])
	by mail.cs.ucla.edu (Postfix) with ESMTP id 900BC3C011BD4;
	Wed, 12 Jun 2024 11:27:09 -0700 (PDT)
Received: from mail.cs.ucla.edu ([127.0.0.1])
 by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavis, port 10032) with ESMTP
 id fqB9_wWc7vAZ; Wed, 12 Jun 2024 11:27:09 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.cs.ucla.edu (Postfix) with ESMTP id 51C023C011BD7;
	Wed, 12 Jun 2024 11:27:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.cs.ucla.edu 51C023C011BD7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.ucla.edu;
	s=9D0B346E-2AEB-11ED-9476-E14B719DCE6C; t=1718216829;
	bh=2X7qXD+1qhqAlxV6q3O3tsOd9Mm+rrNWtzfJMH7WJws=;
	h=Message-ID:Date:MIME-Version:To:From;
	b=qofVBHObUQhoF2w6Icudup7Ywghwx5UZNR5h3P+3OVxzCgDm+yJwCt9T8i831QQ5z
	 4MvsflpJpzhhmOB8bXs8SdiBzC7WUQNayfTq701oz4J5deuNRqz/aLy9nfPQt1Z+oI
	 72rwNsQu6Mzv78DciM17wlZAnpVX+JIUKgnqvZA/pd5C19E9Xm7PGMBpJUsjPSzhWR
	 GR+kfHvxArZBy2YC60xKtWlUZ/OD+1n6Ngvw/aTA3622nZR5rdVAe8U0J9i2NLQGIE
	 Uz04WX44EGAKAOenLDffbfpt17cfv5sDR52EfMdOZZpcthk/8FShPtpRg3LOHdKi3x
	 sOuSFc4ApyEew==
X-Virus-Scanned: amavis at mail.cs.ucla.edu
Received: from mail.cs.ucla.edu ([127.0.0.1])
 by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavis, port 10026) with ESMTP
 id 2CsY03ZyQxF1; Wed, 12 Jun 2024 11:27:09 -0700 (PDT)
Received: from [192.168.254.12] (unknown [47.154.17.165])
	by mail.cs.ucla.edu (Postfix) with ESMTPSA id 23E693C011BD4;
	Wed, 12 Jun 2024 11:27:09 -0700 (PDT)
Message-ID: <be31d737-8263-4e59-8b30-7221ee0549fc@cs.ucla.edu>
Date: Wed, 12 Jun 2024 11:27:08 -0700
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: termios constants should be unsigned
To: Alejandro Colomar <alx@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Palmer Dabbelt <palmer@rivosinc.com>, linux-api@vger.kernel.org,
 libc-alpha@sourceware.org, linux-man@vger.kernel.org
References: <a7kfppfptkzvqys6cblwjudlpoghsycjglw57hxe2ywvruzkbd@e6nqpnxgwfnq>
 <87af5e8f-0dcb-44a0-94de-757cad7d5ded@cs.ucla.edu>
 <mdidkojqnhvf5b22vh3c4b6ajmq5miuyr3ole26kx2qkmnbfh3@woy2ghe5eyve>
Content-Language: en-US
From: Paul Eggert <eggert@cs.ucla.edu>
Organization: UCLA Computer Science Department
In-Reply-To: <mdidkojqnhvf5b22vh3c4b6ajmq5miuyr3ole26kx2qkmnbfh3@woy2ghe5eyve>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-06-12 09:28, Alejandro Colomar wrote:
> adding U is a net
> improvement, without downsides (or I can't see them)

Adding U can change the generated code and thus cause behavior change in 
programs (admittedly not well-written ones). It could also create new 
false positives in well-written programs.

If adding U fixed real bugs then of course we should do it. Here, though....

