Return-Path: <linux-api+bounces-879-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DB384D222
	for <lists+linux-api@lfdr.de>; Wed,  7 Feb 2024 20:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D2781F22093
	for <lists+linux-api@lfdr.de>; Wed,  7 Feb 2024 19:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1248D8564B;
	Wed,  7 Feb 2024 19:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="UxaFWWXY"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B42185286
	for <linux-api@vger.kernel.org>; Wed,  7 Feb 2024 19:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707333370; cv=none; b=tZ/8p72b/oVbdp9emaiI0d8XAP6f6QEJ0TZmSBcNhB8Xamuycc2ROShpZ/871x8PfCZSFHgZ/dWpGk5vod54+umEVVCdZbgmf8P2JSzFyNpAGSBFWQiwua/T2Lyc/CsT5IXnVujfVKgOxAZX4f7kZ0YeIkcWCOaZj24XYNxhXJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707333370; c=relaxed/simple;
	bh=ne+aULSUpaPEi4743IN+wg1mH2cuE/ImHAUIXCyQB6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J7vvGaaT8OVyu4ov6k0e/LqFbrZIiivLH+znYAnoh954a4kqH2MhQxNY53DYp75TdUNoP9OYUGN5pVMt1we0+FuNddesqWy/JGNTZPJD8nASOpvK11YPEsVwp8TxM/HdlzrodReGImzGXZXVqT9UnKqqMrlYbP+JG3GEka8EP+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=UxaFWWXY; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3bfedaaeeacso488261b6e.0
        for <linux-api@vger.kernel.org>; Wed, 07 Feb 2024 11:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1707333367; x=1707938167; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sm8na7VDZ32O2vJx51WDZHRCRu6AvXjFSjD2uvcbmz8=;
        b=UxaFWWXYibJqcRYARqOuCXyRSNfljUIgycHeolNfB01dxd4Dv24IgzZ8BBH9l2xF22
         UWNUXzMtNi31FqOBOlArbRTk3HoITeC1ohLFBPLgUUddwunOYpUHHxy3PVr99R3aNT5O
         GB/J0P+y/rY23QhmDH1l162q+eAzlvSdjmiJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707333367; x=1707938167;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sm8na7VDZ32O2vJx51WDZHRCRu6AvXjFSjD2uvcbmz8=;
        b=Sj97u0UUdA2FK4pWywe6VdPuir4PGgOH5viANo88StMyICobp2PKwHvJW0RR1Kl5Ma
         T1mh6M8nTfDDv264PGVPootk6dfHPFDbb7fPMBVfDqeCg++gHShhvZKCrE/yHjsRlrYB
         7NaofyS/MxIYJfV8YExEfK82jcD7Xl8NJ2e8k4t825eU9nszMMHDjHESrD0zlVgQwCm8
         9hHNivXJE+wnT4jLFlXPm0gzeHTGkRxdfOR1zh/a9FMN2SDzzbzMKT28QMXWzjWhh5LC
         vpV5103zpZta7OIsh1awhHEX6vPinA0Cz38H4NlWpkuNXGrp8qHTOo89h8H5RKdann4q
         9W2w==
X-Gm-Message-State: AOJu0YxbQb4x28DOF7p2AWoT2FsP7O56wDBorhQn8YOhOA2rACQ6WF2p
	UNxf8lzTlxmr/R2UmFRLiF6ySBMSynYl3+uF/7x6fl6y/hEfLlXSaUCdVqNlogY=
X-Google-Smtp-Source: AGHT+IEpdhrPd4EP4V5LmrtuWQvsldZmM0L6GGd8Xxw1V8t7XXLe4+6ucXdG+OY3lX/V7ukb/tUVOA==
X-Received: by 2002:a05:6359:1010:b0:178:9b37:79f0 with SMTP id ib16-20020a056359101000b001789b3779f0mr3806311rwb.32.1707333367454;
        Wed, 07 Feb 2024 11:16:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX6KBZY+Rr7BE/6ADjZAkApu/xJQ5/nhz85kwrS26hIlM6jUnEf+5iQmNHQE9Lyjzj4LDpocM+V729LF3BSXS076ZvwLfpXj87M91D1fA/J8zb8UEcXgHrtdkTFDRfrKwhr/utbGVVYTFm9zgX7ptEC8q0fWPfvAlpLRrEU5ypY43MGSebLdUbxu1GSc94smNhwJHVN+V3ZN/hGVr1+8z5Ud9lpjajhV7xfZqbRTJjjptMG8Iabq4fora7t0UsP7z6TaO0ArjoH+eZtIfFoJMc3Rd1OmKu9qEAPzDbb4rtEU6SASddc0wR9Z+qO6ik17h9b+UF7WKZYl1nFmI9rUB13QENxajXPp6I2ZsZQck2XFnU+7+7yR0yCUcixh26AR+O/NQYfvrsfneRy+Pn4Gl0DAn2Rgw1AQLOzFrALAQMi2U8rlv0hRLMM+90PxytYCsKX9488hsaXPve72+cet3hS8+5dIVvwXYHSwibYc/yyGq8jMIpf/YooBY0gziUk+sy4Ya1bwRv0X9muMz+rzT+lfs+qa7AkmauFlBCODhE3Avngb1oNtQbFpyM5ShBYhfGl8WgCN7TnomYKk0NunQlu+wLVu1IZHUdviUB21R0TyVzl5tkj/7XQv5FJQVvmBAv4iFKWltjzjJ9dWSHP1icqA7OfuR9jC+iZNs/ySOICnhlQ9wenwaSoDFcYansTuQamIBqBulBggIenIwDPy9iXyV0Fn2h2OxaAqAQmt5HGoz88ddECBQIiqIIWGwGneVW4hy31dMkg8rCYa8J2E+wkkS3AhbNv9wg4JWenL5Y2x35W3THgEBXbYV6FyiAg6LbfTH2zWwheBq0XMzs3C1a8IMSmCY4ZgXg/4Rf53QC1JwF0VMFioMCYzSus0KRwQY/bdPJ7Lr28j4+b1OnYyEkNKufOb76kwWQS+b1pPKU8F5PR62++syTf+5Iag/KYWLyBQC
 9rEjkKq0fGBm446COafVJyVns/KhE=
Received: from fastly.com (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 126-20020a630084000000b005d8e30897e4sm1955912pga.69.2024.02.07.11.16.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Feb 2024 11:16:07 -0800 (PST)
Date: Wed, 7 Feb 2024 11:16:03 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	chuck.lever@oracle.com, jlayton@kernel.org,
	linux-api@vger.kernel.org, brauner@kernel.org, edumazet@google.com,
	davem@davemloft.net, alexander.duyck@gmail.com,
	sridhar.samudrala@intel.com, willemdebruijn.kernel@gmail.com,
	weiwan@google.com, David.Laight@ACULAB.COM, arnd@arndb.de,
	sdf@google.com, amritha.nambiar@intel.com,
	Jonathan Corbet <corbet@lwn.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Nathan Lynch <nathanl@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Julien Panis <jpanis@baylibre.com>,
	Andrew Waterman <waterman@eecs.berkeley.edu>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH net-next v6 4/4] eventpoll: Add epoll ioctl for
 epoll_params
Message-ID: <20240207191603.GB1313@fastly.com>
References: <20240205210453.11301-1-jdamato@fastly.com>
 <20240205210453.11301-5-jdamato@fastly.com>
 <ec9791cf-d0a2-4d75-a7d6-00bcab92e823@kernel.org>
 <20240207185014.GA1221@fastly.com>
 <20240207110726.68c07188@kernel.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207110726.68c07188@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)

On Wed, Feb 07, 2024 at 11:07:26AM -0800, Jakub Kicinski wrote:
> On Wed, 7 Feb 2024 10:50:15 -0800 Joe Damato wrote:
> > > This !! is unnecessary. Nonzero values shall be "converted" to true.
> > > 
> > > But FWIW, the above is nothing which should be blocking, so:
> > "> 
> > > Reviewed-by: Jiri Slaby <jirislaby@kernel.org>  
> > 
> > netdev maintainers: Jiri marked this with Reviewed-by, but was this review
> > what caused "Changes Requested" to be the status set for this patch set in
> > patchwork?
> > 
> > If needed, I'll send a v7 with the changes Jiri suggested and add the
> > "Reviewed-by" since the changes are cosmetic, but I wanted to make sure
> > this was the reason.
> 
> Yes, I think that's it.

OK, thanks for letting me know. I wasn't sure if it was because of the
netdev/source_inline which marked 1/4 as "fail" because of the inlines
added.

Does that need to be changed, as well?

