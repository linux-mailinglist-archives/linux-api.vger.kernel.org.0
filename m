Return-Path: <linux-api+bounces-2718-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2204E9C57A7
	for <lists+linux-api@lfdr.de>; Tue, 12 Nov 2024 13:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEC3C1F21BD3
	for <lists+linux-api@lfdr.de>; Tue, 12 Nov 2024 12:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FC91F7787;
	Tue, 12 Nov 2024 12:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="S6vJXNmo"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838B71CD1F1
	for <linux-api@vger.kernel.org>; Tue, 12 Nov 2024 12:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731414311; cv=none; b=ulB+Ppr4zeLQtNXApPFdtAbItxa7LS8+AOSnrvR0ahS2rKhRHN1fqujHTwodKw75j+/2pG046wzzg3Hs8O1OvqQK16jZgmzkVcqB1VUnSawAgs5otWCdKJ1ApTIb7+Qpc08RIf8HHDjuTHf7UeofRMBGD+guXrbJj/cvxR3aYeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731414311; c=relaxed/simple;
	bh=ASY4bPB4Px7WeCr2Y7OxTi1Nmqlpm6jnNhyzgm+Og9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D8V7s31aaVoTz7vJvLhsKOWOqXrMjagPIQgSYEZqdNFjTyex8kSgw4pKiK8UOz/qV4cdEVIBQD8nZUlcVaOprILf+z1WFUWjZAZ+cdicp0u5G9psPLgj7keEn6kbktbMHwFs8LjN2Db0/mXiqWMUhp2yxw758utlArjvWCBUqKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=S6vJXNmo; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6ea051d04caso44398457b3.0
        for <linux-api@vger.kernel.org>; Tue, 12 Nov 2024 04:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1731414308; x=1732019108; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SV8KkwWhcMq8zPlEHm22sSb2CDAzVzMGoMg1i907Q58=;
        b=S6vJXNmo2QSresLGrx78Xm8LfsEpbNiQeqom4R18ko8FTAY6a0j3wAX210HvJCF+i0
         6gnkNJZ0ifYeheTGxiafcmObZbkbvegHfE2nsDarTgtx4W4Tdwx/Zwrcchca9g9OW/we
         xHxh2vq66KkPxqj0xs9vTPiEV0T7j+4ubKzfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731414308; x=1732019108;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SV8KkwWhcMq8zPlEHm22sSb2CDAzVzMGoMg1i907Q58=;
        b=BP5FZvTJL1Ao4CUMqnFZV35kLqCV9QUx3pkLGemH9m4o1cl+/X7pnCo9nDsgmkcGJR
         zTXLrvRiw7kPwK+CoWzf5pGnIajVmn5Di1/N7hHt85A7dLQW1uW6AuNvQmPBNzwR2JII
         nxx1jW9HORPh06p2dRzwXNUquXGODxJe0TtF+bDg/1Lvyo4ZxRgn67pJkJMiJboNZUp4
         xsO0mYis8DkEMF9iuGNeA21LEh2hk4Vq6MxDfKPNYz+OFVOipsCJqRIozylD4Yq+2t6E
         4Db0xaMG/iy9eKHInj264FQiaTwyGux8c85jkmyBMFTYznYU2lO/TZ8pqVTpLH8Zg1fB
         WLkg==
X-Forwarded-Encrypted: i=1; AJvYcCVCCHSKbDgCYkTXeicpp9dqH0WC22ereNNVJdJM6hID+oHHdzcMK2WW6UrrVBfzZQo0AhfRITdD0B8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOySi75wkH88Fej2Aa/tN2d4tXwrhQ8UzoESkXuHW6WfCqWonT
	/yThWoih3p5Mn0vnBWakJ0j/NmRmXRhO0kjW/rZlyuYl48IY8/U5L8ur6THSTMDljOOgdpdlLNy
	ctp75OZpeeeKBHgvzIVaLJc0gw/i7LlSH0dTH/Q==
X-Google-Smtp-Source: AGHT+IH91Dxxf/wxCv1pPjNNDhur8wmwHI+0WV4WNH/+V3HOygot9pF0w2WhVaMIfGLaYWXy7ScCadmt9eCymc58cPs=
X-Received: by 2002:a05:690c:4d89:b0:6ea:4d3f:df9d with SMTP id
 00721157ae682-6eaddd71c30mr157563907b3.4.1731414308586; Tue, 12 Nov 2024
 04:25:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112101006.30715-1-mszeredi@redhat.com> <2faa89f0ad18d8f8015f65b202f8ddc64a810a71.camel@kernel.org>
In-Reply-To: <2faa89f0ad18d8f8015f65b202f8ddc64a810a71.camel@kernel.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 12 Nov 2024 13:24:57 +0100
Message-ID: <CAJfpegso0Rd8DK0BYAPgSCHKJgbYX2iO7d4qMqGifBuGFaoE9A@mail.gmail.com>
Subject: Re: [PATCH] statmount: add flag to retrieve unescaped options
To: Jeff Layton <jlayton@kernel.org>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, Karel Zak <kzak@redhat.com>, 
	Christian Brauner <christian@brauner.io>, Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Nov 2024 at 13:20, Jeff Layton <jlayton@kernel.org> wrote:

> If the options are separated by NULs, how does userland know where to
> stop?

The number of options is returned in st->opt_num.  I find that clearer
than returning the end offset.

Thanks,
Miklos

