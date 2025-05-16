Return-Path: <linux-api+bounces-3791-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F88ABA17C
	for <lists+linux-api@lfdr.de>; Fri, 16 May 2025 19:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 994EDA221BF
	for <lists+linux-api@lfdr.de>; Fri, 16 May 2025 16:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC74425392E;
	Fri, 16 May 2025 16:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="BWJIchwO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="gD4HiA6b"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.wizmail.org (mx.wizmail.org [85.158.153.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F3624729D;
	Fri, 16 May 2025 16:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.158.153.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747414742; cv=none; b=aD5Ro5pKWpq/LwGFQduKkHnyaPZHYuzCHQ23lzP4aCQRs9lCiWPDsySt3w1BS+7iQAedSJ99u2TJ3xU81k5eRooUNZ6EjkkGJyoygbk83B5wAK6ZiepirG1obX9k79ycT9Qhsb0BGtZBHBjgO+g22gl/2SqUtGC9lhbLeOwLseI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747414742; c=relaxed/simple;
	bh=5YgBGUbiic/MC1/wwtYMy0uYy/LVurYgeVZrKfaJTgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OSJaPInP2it0ytunOMGyr+j3f+acho/cPQv+yW7zm8g+KxtN/NZUcplY89TmbnPBKsNikd0ePMCTqX8/VG9yGKVrxKizXB4rVT7XKxh/HInmm80HbD3xqDtBPZeruAR7pnDgtGe5c73AHg+yQme6f4xFjA6oPkZnutAg80Nxvhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exim.org; spf=fail smtp.mailfrom=exim.org; dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=BWJIchwO; dkim=pass (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=gD4HiA6b; arc=none smtp.client-ip=85.158.153.28
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
	bh=gJewzccq10pkwVoPvyiEPBFkI4/Mxugn3vSYlvK9elE=; b=BWJIchwOvKZ/kc1sqSPdWJ6ofU
	l0MY8D+Ri53FmmsMmfRbKVVz3m7Edb7qyEUT8MguxhYYT7Ma6944ubOkKxDw==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wizmail.org
	; s=r202001; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Sender:Reply-To:
	Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive:Autocrypt;
	bh=gJewzccq10pkwVoPvyiEPBFkI4/Mxugn3vSYlvK9elE=; b=gD4HiA6bd9uTv6PS0LMbZFone5
	Bi8UgNK3M2eID2cG+vJYwJfHNiNr7/Vb1kiZW+JK2DAvUw+12LNFyZQ+NF3Fl8hhYIvt9yNnhm13K
	xTe7U4YgnV83A8ONqsN+C+0kIwP/PiuaOIxdoA8gAquCAFLd2r06L5J8SmMb9qY/QHoivLuTDz5Gx
	c7vbsgZut7iEuYS69XsJPcW1M9tlQMn6TZsTdhwJPcDhwOsh25TbUA8oW2WYvFc0x7RF6hevX0i3d
	vIxuJbjmnMNJSmEYcnyzwybUpTIyOf2yKi1qjff+8BwaCSCiGZ6cI038IJgNzL4l8Y8XTAyd8FDT2
	HFcIwaHQ==;
Authentication-Results: wizmail.org;
	iprev=pass (hellmouth.gulag.org.uk) smtp.remote-ip=85.158.153.62;
	auth=pass (PLAIN) smtp.auth=jgh@wizmail.org
Received: from hellmouth.gulag.org.uk ([85.158.153.62] helo=[192.168.0.17])
	by wizmail.org (Exim 4.98.115)
	(TLS1.3) tls TLS_AES_128_GCM_SHA256
	with esmtpsa
	id 1uFyOe-000000074ht-2YEE
	(return-path <jgh@exim.org>);
	Fri, 16 May 2025 16:58:56 +0000
Message-ID: <966fc020-094e-42e4-8c56-1625f7175737@exim.org>
Date: Fri, 16 May 2025 17:58:56 +0100
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] tcp: support preloading data on a listening socket
To: netdev@vger.kernel.org
Cc: linux-api@vger.kernel.org, edumazet@google.com, ncardwell@google.com
References: <cover.1747409911.git.jgh@exim.org>
From: Jeremy Harris <jgh@exim.org>
Content-Language: en-GB
In-Reply-To: <cover.1747409911.git.jgh@exim.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Pcms-Received-Sender: hellmouth.gulag.org.uk ([85.158.153.62] helo=[192.168.0.17]) with esmtpsa

On 2025/05/16 4:54 PM, Jeremy Harris wrote:
> Support write to a listen TCP socket, for immediate
> transmission on passive connection establishments.

This series should have included "net-next" in their Subjects.
-- 
Apologies,
   Jeremy

