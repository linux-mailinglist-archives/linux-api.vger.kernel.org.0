Return-Path: <linux-api+bounces-3796-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FD3ABA487
	for <lists+linux-api@lfdr.de>; Fri, 16 May 2025 22:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 891E0505A04
	for <lists+linux-api@lfdr.de>; Fri, 16 May 2025 20:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948F222B8AA;
	Fri, 16 May 2025 20:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="JRP9H7+s";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="lf5sd0/p"
X-Original-To: linux-api@vger.kernel.org
Received: from mx.wizmail.org (mx.wizmail.org [85.158.153.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E991A704B;
	Fri, 16 May 2025 20:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.158.153.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747426308; cv=none; b=SuJYamKYEW7cY4itmwPdkBlORjlkIr39Qb1wl0CMPlILtXEk9LVtcU30pnljSCs4dGrkhFKtUeNrGo6oQf4ir3keq3tnlELzWsF6GjUhd0n2flpvEDrGRSMN5NrAKqHVxo063C+9QzaOwblIvL5zeWnpt1cd50BsZElvpzHgGXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747426308; c=relaxed/simple;
	bh=cJDG+nML/k0VhCxpkYDIBmzo/4YjTiv3DAm5cOimtmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZBT9bjx/t3z8KsSijCBAe6Qp64sWOo6h/vq9z9Ovdv9+VFh6E8rtLdkzP44EJ47MpEi5JaOK0/ereGkeBcKwKRN8UnWI3Tt8l5fe/8APHhZqrCi7XGbFB4Df1oKP6m06QwWaR/QevJsWWcB5u4nV7Fv7y2tLhAaWPGzCtQ8twAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exim.org; spf=fail smtp.mailfrom=exim.org; dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=JRP9H7+s; dkim=pass (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=lf5sd0/p; arc=none smtp.client-ip=85.158.153.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exim.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=exim.org
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
	d=wizmail.org; s=e202001; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive:Autocrypt;
	bh=tnZ+SElty12PttDspdX87N0GhxUxhAEHg4fOgjhaOks=; b=JRP9H7+sCJS0uOEeUk76ShzNMC
	H8WBND5gOgxWG4eNYzEksY4dYV0iBWaz+V3Vr5icsoEqKfY720takU7HMmDA==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wizmail.org
	; s=r202001; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Sender:Reply-To:
	Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive:Autocrypt;
	bh=tnZ+SElty12PttDspdX87N0GhxUxhAEHg4fOgjhaOks=; b=lf5sd0/pg4pMFJlIyAHbQpnGjx
	rzCLKTOkn8jKpZR6JVcy9wUJkS9AVIROo7C+Et+114uBSNJY8BEi/M4oeVi5/X23o1PlIyjqc+oUi
	3Jwhvh/yL83NEIj6TiiPKvEUKLT+b+9DoEBj1t6Zpvw16Cp2kb8VRm00zrj8oT/D76I4OfpUquwXo
	h2SG3aV+BHCdH5EpIazdR8q4Lvux8olLv8TapQiPc/FHBwJ3SukAf6k5GkSGHRJ2udPqmpPAKWPao
	7NGhdNHlHUFnoNco0vA0U9oi857KCw9V3JnsE/aarMXz7l8w5IenxifI/D2jt3ixVC4kjMKCklyt4
	tRV6EszQ==;
Authentication-Results: wizmail.org;
	iprev=pass (hellmouth.gulag.org.uk) smtp.remote-ip=85.158.153.62;
	auth=pass (PLAIN) smtp.auth=jgh@wizmail.org
Received: from hellmouth.gulag.org.uk ([85.158.153.62] helo=[192.168.0.17])
	by www.wizmail.org (Exim 4.98.115)
	(TLS1.3) tls TLS_AES_128_GCM_SHA256
	with esmtpsa
	id 1uG1PE-000000079Wa-1dd3
	(return-path <jgh@exim.org>);
	Fri, 16 May 2025 20:11:44 +0000
Message-ID: <1a695707-da6e-4427-ad24-a7f8cad85169@exim.org>
Date: Fri, 16 May 2025 21:11:43 +0100
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] tcp: copy write-data from listen socket to accept
 child socket
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, linux-api@vger.kernel.org, ncardwell@google.com
References: <cover.1747409911.git.jgh@exim.org>
 <702375d7dcc673fa1f97c92ddf86b47d11106db4.1747409911.git.jgh@exim.org>
 <CANn89iLNEnF1YYwOmPsuQn6n-O9N9yVxnZ_djEGxaZ11i4AsVA@mail.gmail.com>
Content-Language: en-GB
From: Jeremy Harris <jgh@exim.org>
In-Reply-To: <CANn89iLNEnF1YYwOmPsuQn6n-O9N9yVxnZ_djEGxaZ11i4AsVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Pcms-Received-Sender: hellmouth.gulag.org.uk ([85.158.153.62] helo=[192.168.0.17]) with esmtpsa

On 2025/05/16 6:51 PM, Eric Dumazet wrote:
> I do not see any locking. I think you should run a local KASAN/syzbot
> instance and you will be shocked.

Thanks for the suggestion; I'll look into doing that.

-- 
Cheers,
   Jeremy

