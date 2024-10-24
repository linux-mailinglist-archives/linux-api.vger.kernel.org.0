Return-Path: <linux-api+bounces-2560-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3579AEF32
	for <lists+linux-api@lfdr.de>; Thu, 24 Oct 2024 20:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B8471C20DD0
	for <lists+linux-api@lfdr.de>; Thu, 24 Oct 2024 18:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA2F2003A8;
	Thu, 24 Oct 2024 18:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gJRrp2vm"
X-Original-To: linux-api@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6101FE0EA;
	Thu, 24 Oct 2024 18:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729793322; cv=none; b=D6FjEjXFbH2ZWIA+SgoIGDCScpOZ6dm2Cm5jRgXMcZZgXEVucPV5XWNjAYRC66rqdU4ljO2ZHFtuNcQq1JMObteABbpm+WgaakZ4Wd8iqak5tyNpLZwMNrmQ722x1vw7ydO4jT2Tj0NptIL9dz9QXkNF7G0MlUb5Kjim15P+4FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729793322; c=relaxed/simple;
	bh=xfkR4ma5b5dJE/tDvi6lHfWQrg589RQLZprUzaZnmGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EhY1QVrqwYqxNXWLNR719GampS2QHdmxww6Tuu5Yxq/uyuvZCkUSzDXR2E9jYvgoFQ5rcbCg9ax7vburr8VI2F6d6uNaBw3ycYm1pcpdrAV2jZF5+pElDkmCXm41YjmmFoGFsrJcf7B2Op8gmWg+NG0ouMNMateWcBehRHNoV3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gJRrp2vm; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=ZfKI9T+QnjDlxWNoLS5WhgjTkXwvW1Fl9+wws3DEJj0=; b=gJRrp2vmt+PRXCJ2tmylKoPnca
	g7IONkF/B/CTdv6ZbVgMtro9h5NIASrR1hpA8oUNzpX4It7Ytd5FW1tH46Q952EYKBwzcsGAyL8eh
	EUxnKnOZK2mYuQZxqbxhL/yovnYMrWtp8ElkkgYP1vDJAi2zbPBCwP9RVnamNweKQiKMcyyAEIw+R
	t5ExI3oA46ztlMi19LVwIRbZVz5cc0rALbyqIkOBpFRoceUl0Q8Jw/uu1+1qa1BJPirobA7V5dfzu
	/4ui/xDmmHZmZa40tEJsYgDwkoIeHbFyjpKXXMif6lWT7UVaLzr63dycwRusY9ivlF2x39sz4Uo4y
	s0JiXLHA==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t42G7-00000008ipU-41sQ;
	Thu, 24 Oct 2024 18:08:32 +0000
Message-ID: <43494f80-c383-41c0-a3ef-0e4879ca7d80@infradead.org>
Date: Thu, 24 Oct 2024 11:08:25 -0700
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/1] futex: Create set_robust_list2
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Darren Hart <dvhart@infradead.org>,
 Peter Zijlstra <peterz@infradead.org>, sonicadvance1@gmail.com,
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
 linux-api@vger.kernel.org
References: <20241024145735.162090-1-andrealmeid@igalia.com>
 <20241024145735.162090-2-andrealmeid@igalia.com>
 <bde852ec-8e2f-4957-9368-00d8e5a422c4@app.fastmail.com>
 <1e62e083-f97c-4157-8d50-c3655edda97b@igalia.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <1e62e083-f97c-4157-8d50-c3655edda97b@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 10/24/24 11:03 AM, André Almeida wrote:
> Hi Arnd,
> 

Please consider putting more of the cover letter explanation into the commit message.
Thanks.

-- 
~Randy


