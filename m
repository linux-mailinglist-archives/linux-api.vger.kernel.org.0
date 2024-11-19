Return-Path: <linux-api+bounces-2763-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2FA9D2CE0
	for <lists+linux-api@lfdr.de>; Tue, 19 Nov 2024 18:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAA1BB2D34F
	for <lists+linux-api@lfdr.de>; Tue, 19 Nov 2024 17:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCD41D1514;
	Tue, 19 Nov 2024 17:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AdrexOEo"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7898D1D14FA;
	Tue, 19 Nov 2024 17:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732036839; cv=none; b=NhEu6p7G1EzNspQHSrtMpt7/jnH6BBrvEZ5NJwXwg4Igy2W9j5lmgJ4t8HhH144SG3Y5AKwk8dKDw6wbrkYNBGDvHnHbpLfWilZwE0X70nGEo/h74APopIIpvOqsR76s58pwYkDG3mZBLsGPvNLbTGYQMShrwGv1NknL11samU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732036839; c=relaxed/simple;
	bh=+QUn9RVv2knq4ZX/1kGdyZ9vvW2Z7c/Y1BrZzf1V/DU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uUmwcR7PjFJrKbFmkjfuht3YRQ0fcemmEf+Vx5HJv4/9EyJusa9e6lJ1uFFDWpQgUWJV56ZAGaXdY0XIhfl6QID/MNRjNfTE7RotL0HyVXEFCG35/7bqtnfingdckW8hu8Z8kWbxIZzL2eNG5FWWvl+kbsx7gIq/SRGgNA/NhOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AdrexOEo; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9aa8895facso210895266b.2;
        Tue, 19 Nov 2024 09:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732036836; x=1732641636; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=welmcQJz/KrmZ/exPeKgeWR1HgNuvSB6fXyM+tgH12w=;
        b=AdrexOEopOn/2Ixf5KswvEcIdm+LntP4RXapGinORuOoKtRzw7SuTZ0hdv5YVTh4Ek
         IUHOsdSNzIdwTEG7JwTkT55E2+BsBPJiBLlCPrKnxA6X/S/O8GBEHtNXVpYmicaLBrMJ
         e0EKSSmG63HkGXjaNteIyjKEHikFytRJdvfgfZNMmwnb+UWUe8wyNY7YEbO3rqPpHAL4
         i2m9C6j6FYX6XI23TR7lzq9+mmjc1G3/piQr5JQBwVoJdi9r12x/iLE1SmneA29rd5ih
         qI+2TQrZbmxIllXpZGHk3T+20DACpyVEI26yO82c6samipbG+6TVd/R8qVXyf7AvsX4z
         UD+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732036836; x=1732641636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=welmcQJz/KrmZ/exPeKgeWR1HgNuvSB6fXyM+tgH12w=;
        b=dLM88PJ17bIt5LZTFQCGu/nP+Oc8EI2Qo2fhskidsTu3NfGVZkpcY6eKn2q+wVM3Pd
         0OeikOo+ifOCJwlPDsh+MiUDzf7HsepYObHGpXPF+vvaLmL5W6e1sDc+poD1A+T9Wfub
         PrlkvBEB+nkiNiraXCZsyR2pnRMx8n/8uFkktcIBb3niA3H57oJuZ0tVX0K3PBahO3DK
         mopX6kZsVcdIJRRxCb4K0TzarS6QMHFszpdu0/9LzSCvWzMCpjEm+LOyL7Hcxa6BValP
         O20cvz/4VlXrsTlTJ+DRsIEbvd7DLMKovm4XL/Pv36Ojt74QBTv/IANor8bOYuGVX8GA
         7lpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMt4n99TzpcrdbA6FQ+YwODNDaziSmEdeUm3GlzoCFJ+SlNlNHM7vpQkfclV5tDSr+a08Fy97naXI=@vger.kernel.org, AJvYcCVMRBELEMF48JYJ8MSqws/3h8gNVm+9C2Mu6HQmaxrRGjVyK/gOnos6+2VQlESop9lCoj7ABXTlofBE2F4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6G8XWu+2JBdbg2m27ZV4s8CYBZa+kLd5lj1QJ5+x53ALmHsbs
	Woh2dma6cq6wf9wVeE1GZ1zjZqaYUkmbLSQciWD3KCQafCkYoYE=
X-Google-Smtp-Source: AGHT+IGvI0RRBn2Z5tbFBL0Z6FFCUyXENtg8HuIrR1t8wCPqQe0HFcxvJjPEUZa6EREMXFwM4R//JA==
X-Received: by 2002:a17:907:d08:b0:a99:f167:47c7 with SMTP id a640c23a62f3a-aa48355292bmr1668616866b.55.1732036835608;
        Tue, 19 Nov 2024 09:20:35 -0800 (PST)
Received: from p183 ([46.53.252.27])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20dfffcd4sm670156066b.98.2024.11.19.09.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 09:20:35 -0800 (PST)
Date: Tue, 19 Nov 2024 20:20:33 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-api@vger.kernel.org
Subject: Re: [PATCH] uapi: add EROBLK
Message-ID: <dee8868f-45fa-40d7-bcaf-a46bf768e400@p183>
References: <9184b5e8-7070-4395-b179-4975b2e3fbc3@p183>
 <Zzy7MGyTp9yw1ntQ@infradead.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zzy7MGyTp9yw1ntQ@infradead.org>

On Tue, Nov 19, 2024 at 08:22:08AM -0800, Christoph Hellwig wrote:
> On Tue, Nov 19, 2024 at 06:54:52PM +0300, Alexey Dobriyan wrote:
> > Block drivers and DM sometimes use EROFS to report errors. There is
> > no confusion about what happens but naive error reporting code might
> > pass -EROFS to strerror(3) which will print "filesystem" when clearly
> > there is no filesystem anywhere, it is layer above.
> > 
> > Or in other words, if EROFS exists, why not EROBLK?
> > It is not like there is a tax on errno values.
> 
> And where would you return this value without breaking existing
> userspace?

New code may start returning it right away.

Old code may start checking for both and in ~100 years delete EROFS
clause.

