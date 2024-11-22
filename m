Return-Path: <linux-api+bounces-2781-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C52D9D656E
	for <lists+linux-api@lfdr.de>; Fri, 22 Nov 2024 22:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06434283128
	for <lists+linux-api@lfdr.de>; Fri, 22 Nov 2024 21:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A47185B46;
	Fri, 22 Nov 2024 21:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i34aEf0i"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C32249E5;
	Fri, 22 Nov 2024 21:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732311773; cv=none; b=LFWj2t8tZfaJwI84YnQO71hpj0rLqLShUhAWCbKi/OJEpMkqjzaiSMVovR36HaqVrqbx1bEkF/OI/gghJOWSqYUrE6w0ipkjrM37wDCqah6Ytr31ISQznifK/kZNAQYj9anJjoXXuXyO/rgNq1G1I6/ZI1OJ6RBX55eYcCpeGgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732311773; c=relaxed/simple;
	bh=VaLYmEpXCswJ+tfNQNgAdXhQYI5DC7J682/Jc0Tbya8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O5ykQ7ACYIYy8e0j+zE+l4EEttjh3cmy1zglpT+oJRq8g4mpXsk6DQ9eEr2LYvUJEzJjxa4knCwqjGDGndb8lxIGHbZxH/XHPZTUr0AHb2UgfWkYGvz/9ol4iiMX3PICZvv2/AydFrZkrHjV5XIj1mR6Ez58OOi7zbtDoOurfMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i34aEf0i; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7ee7e87f6e4so2249336a12.2;
        Fri, 22 Nov 2024 13:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732311771; x=1732916571; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dVXpF38JqcLyXbRWoQHlti7bjH/SZY1G/SV6qnKaZtA=;
        b=i34aEf0i0WF0FaJvy6Fa8BAYVbCajZnyQNGTkJWbRbWsZ9xeUc4M2wAWALQeDQ74mZ
         cbgSiuFmiqcvJnW5NSVo4kBzH49m/mx2Fe7zOHLpE1XEhjsRpxAArjv0rXByql348ju8
         iooLp9vcvQt+1Svw9fRH5pjyZOyyhQWr67LKahB9EWdGHtLLh+Zt191WxCA45SStFHK9
         G7i4y7p+0SYwo00tY5cipizlPzKoCDsiZJxq/Sgj7+A4jeV/YnNB3Rm4/e/ku8KvBxrX
         nH04t4gnE2CE68qMzUNXOhpV0M0RtTS6YnZA9lD9xU3cMjA9ezxPbQU5f8xBMCwYEKVc
         UG/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732311771; x=1732916571;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dVXpF38JqcLyXbRWoQHlti7bjH/SZY1G/SV6qnKaZtA=;
        b=mwtfJiAjRobs4OTjx/21G5EEcYWCbfGi6WmU+htf2mqnKENRmbr0TrAQ00lOtIo2B3
         ge6722cELZK/Br8y0I6xiJG2vNt9VQJmJqnISaU6bVLopuPGOcJ8hVtm9/zYK81J6QA3
         Ksfp4IZRuzpUUhTkiFGJKw8TdO992LFEPtAL84ONwq+foIA1EcSsL6kDHay4wIBgWDe3
         yY1QL7fANWx96+FxK8AO+KoLYGCSSh1Hfim6ASmkt53sphuO1T9MKLy61+mA6BdQflyv
         Pmxtt4gAQinplLZ+ENSUB/9iJ+H2JRdmjkcApUWW3AkwTBVOo5oLAXqywCvEEbwLW+mi
         e7ZA==
X-Forwarded-Encrypted: i=1; AJvYcCV2Ol1lsEuSxQ8y7FPPJIPG1AdswwBEXltCLACNqOtwe6LlGg0ClfAGXC6l8eRqVszNuF0a9ltHVPA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy5mKTSBBt1w7WV6ogWMAlAktztWYrJWxIfudrFiKRN4MH88+3
	boiiN48zBS2M8AyLV+LEOZLJuqBLG+18M7bO8LQ2KrqgVhyMeALsNAYZ8Q==
X-Gm-Gg: ASbGncsSWg4hTXNWrjhrl3wlnRVQ40op4KbN2HY2K0eWTKAc8P1ClWsqFZVMKBUWZu0
	gBKtF6kH01nFtChtBzgj+I9H3qj29B8Rd5i1/EQ8z+VKbMJMfQ9EEybfcOcOnGwIuSiKzs6Sg59
	r7Q5Eg1CHM9cFLq3voryMRW13IOFI+R0gjnn/5gygI82ClmuNMLxf+TJMergqeKN9BkT4PaEaYx
	9jnU3fficJDZ7XMNOXuMmW9VW4zAavBS74jKngP2VyUeJaChv7BnsIr
X-Google-Smtp-Source: AGHT+IHkNDho4rEQiyLyhahL7QPmYF8xplygAcqlvjAumGRvqCza/cbWnLN4h3DaSDZYnoqzIClbaQ==
X-Received: by 2002:a05:6a21:790:b0:1db:f0e0:cfd with SMTP id adf61e73a8af0-1e09e5fecd0mr5015368637.44.1732311770947;
        Fri, 22 Nov 2024 13:42:50 -0800 (PST)
Received: from localhost ([2601:647:6881:9060:5940:b3b4:d5bc:a0b7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbcc1e5ceesm1843342a12.33.2024.11.22.13.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 13:42:50 -0800 (PST)
Date: Fri, 22 Nov 2024 13:42:49 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: netdev@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH net-next v2 00/12] Begin upstreaming Homa transport
 protocol
Message-ID: <Z0D62cS7DgkHYEDr@pop-os.localdomain>
References: <20241111234006.5942-1-ouster@cs.stanford.edu>
 <ZzTcx8nmEKIJpaCR@pop-os.localdomain>
 <CAGXJAmyGTwjFo6fGoROY=hQFXbR5RdpmpkEc9Zm6DOoD2nbwNA@mail.gmail.com>
 <CAGXJAmwr5u7Don-nKivvTuj6C9pGT2A5cAXvhKo6sAm_hHy72A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXJAmwr5u7Don-nKivvTuj6C9pGT2A5cAXvhKo6sAm_hHy72A@mail.gmail.com>

On Tue, Nov 19, 2024 at 01:13:36PM -0800, John Ousterhout wrote:
> On Thu, Nov 14, 2024 at 8:59 AM John Ousterhout <ouster@cs.stanford.edu> wrote:
> >
> > On Wed, Nov 13, 2024 at 9:08 AM Cong Wang <xiyou.wangcong@gmail.com> wrote:
> >
> > > 2. Please consider adding socket diagnostics, see net/ipv4/inet_diag.c.
> >
> > I wasn't familiar with them before your email; I'll take a look.
> 
> I have taken a look at socket diagnostics, and I agree that Homa
> should support them. However, this looks like a nontrivial task: there
> appears to be a fair amount of complexity there, not much
> documentation, and the current diagnostics appear pretty TCP-specific
> so it may take some work (and advice) to figure out how to map them
> onto Homa. Thus it feels like it will take a fair amount of
> back-and-forth to get this right. I would prefer to defer this until
> after the main body of Homa has been upstreamed, then have a patch
> series that is dedicated to socket diagnostics support, rather than
> lumping socket diagnostics into the current patch series. Is that OK
> with you?
> 

Sure, I don't think it is a blocker here, it is just a nice feature to
promote Homa.

Thanks.

