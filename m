Return-Path: <linux-api+bounces-2731-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 087BD9C799D
	for <lists+linux-api@lfdr.de>; Wed, 13 Nov 2024 18:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2101283D3B
	for <lists+linux-api@lfdr.de>; Wed, 13 Nov 2024 17:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C6C2022CD;
	Wed, 13 Nov 2024 17:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GnUwi5e2"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F02320125C;
	Wed, 13 Nov 2024 17:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731517703; cv=none; b=BEYsLVzrLpjfHt8N4O5tu5Km3/H06mGOI7/quvA+atbby5DwfSwofY0mBqLGDUet1TBbQqTwghwbxzg4PXPsQrBI5SPyIJJ5OkS6mbVIBGRMd+/w6A3zLsnxtET+j9M+X1JqOSbZZ8lBLUm5QPKnaS1qf9raUeydL8p1Fk30nSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731517703; c=relaxed/simple;
	bh=sv48yDx/wG/stFJCX2NJV/aI7SdG60XO/GbaG2OQKZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S/2khAoK4G/QA2qGHoTgA/9ObTluVxYSptEu57DXIwMcOGR/g8x2QSyPO+QKYJki1+5iVZeIBvv+q0NQHTeMy9JoPuEkN3l3zikLr67IMt/2ggSCANrCY/RY0MbA2QeDZvpG/foMd9l/Mw/Mlmfchy9gxa2xW0PZ3DY6jiq6EG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GnUwi5e2; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e9e377aeadso1991677a91.1;
        Wed, 13 Nov 2024 09:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731517701; x=1732122501; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lL+B9QCGo8H3/RwHAMa3FCLFw0JXr8tvHEmdnetilJI=;
        b=GnUwi5e2skuJKZ2Rpbii5/2/sLY7lv2UpH5eQlRNbgmOTzwDwEzsG7Bxfg6kpm7g0T
         3i9PnYpykD88sczMRrvB/VfYzVOwioSlr1orKKqQn3534LiIlROIJ6ojC2PyymvcDc1K
         8T05RpHtHnh+fDy+NSiqCkjLcNnKQHCD0noQtb4+do2EXz/+RQewNLD0isT+1kD+iN/T
         K18yJzAUUW1HYYZOPFDK0bAHmBMp1tf0vO3OSyU4F1Cz75wPV4Qv8IRnkJE9yY27krpy
         AWudw78cFixYAorf8Yu7Tq3tYMgTZEU5ysdCeukIRF0DNf+Y7kAjj11ajruA17HpQCKN
         FdwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731517701; x=1732122501;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lL+B9QCGo8H3/RwHAMa3FCLFw0JXr8tvHEmdnetilJI=;
        b=nJitlIweE4cBU8e0X+HzKN5wzA+7ZiF+imORUXVaVj+WqXjfQwA/yWh582PNnJqQVJ
         FlJfIGRDuKkaJg8Rk3cct0DEXs9ZaFXGKVDEAd43Jk0O/h6gxpDmB6KZIVC+OfCA2NAc
         yAdcRF29CFKL0j31ndp2OO+H56kkyLZYyvFTZjVdSfOftR4nwesrj0pneSCZTxC0T7kD
         knu9tlKKKSQvDt53Qv5Gs65ExE+13HL2FOb1xNPbeBUJJuBnudXwLvX7bHpgYIrrIutK
         mMAXSH8HMWmVRQf1TvPhA+yYKcxS/2TF7tOKZoa5bjnXVUPCEW6bdvjNkxVLOo7hYoso
         6HLQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3Jaz18033uo/obkqI+7ZlePJJUWFtQwFXAZJLQ6OX1Um2hjFkM73tFuZUgoryZ9V68AJLGp4amg0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlZHjunQR97YcELXzfVqSu4bWfKjFS8rW7BnMLF/a0KJAEq85S
	nd92pn69hFn9cwsGNFVrzw/ulBFAgFGMl3+kBOrD87DovTjD7p10+hGjCg==
X-Google-Smtp-Source: AGHT+IGBpXLuT5hJHY/SlFsU+0JPDwIxuhDHSBWAZC4Q0L8nZ3NrphVVuQTvCpDYVhu2eY1NYKOJ9Q==
X-Received: by 2002:a17:90a:d450:b0:2e2:857e:fcfb with SMTP id 98e67ed59e1d1-2e9f2c9061fmr4130621a91.19.1731517701458;
        Wed, 13 Nov 2024 09:08:21 -0800 (PST)
Received: from localhost ([2601:647:6881:9060:7f:632a:2d4c:6c6a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9f3ea55d6sm1738524a91.9.2024.11.13.09.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 09:07:45 -0800 (PST)
Date: Wed, 13 Nov 2024 09:07:19 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: netdev@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH net-next v2 00/12] Begin upstreaming Homa transport
 protocol
Message-ID: <ZzTcx8nmEKIJpaCR@pop-os.localdomain>
References: <20241111234006.5942-1-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111234006.5942-1-ouster@cs.stanford.edu>

On Mon, Nov 11, 2024 at 03:39:53PM -0800, John Ousterhout wrote:
>  MAINTAINERS               |    7 +
>  include/uapi/linux/homa.h |  165 ++++++
>  net/Kconfig               |    1 +
>  net/Makefile              |    1 +
>  net/homa/Kconfig          |   19 +
>  net/homa/Makefile         |   14 +
>  net/homa/homa_impl.h      |  767 ++++++++++++++++++++++++++
>  net/homa/homa_incoming.c  | 1076 +++++++++++++++++++++++++++++++++++++
>  net/homa/homa_outgoing.c  |  854 +++++++++++++++++++++++++++++
>  net/homa/homa_peer.c      |  319 +++++++++++
>  net/homa/homa_peer.h      |  234 ++++++++
>  net/homa/homa_plumbing.c  |  965 +++++++++++++++++++++++++++++++++
>  net/homa/homa_pool.c      |  420 +++++++++++++++
>  net/homa/homa_pool.h      |  152 ++++++
>  net/homa/homa_rpc.c       |  488 +++++++++++++++++
>  net/homa/homa_rpc.h       |  446 +++++++++++++++
>  net/homa/homa_sock.c      |  380 +++++++++++++
>  net/homa/homa_sock.h      |  426 +++++++++++++++
>  net/homa/homa_stub.h      |   80 +++
>  net/homa/homa_timer.c     |  156 ++++++
>  net/homa/homa_utils.c     |  150 ++++++
>  net/homa/homa_wire.h      |  378 +++++++++++++

Hi John,

Thanks for your efforts to push them upstream!

Just some very high-level comments:

1. Please run scripts/checkpatch.pl to make sure the coding style is
aligned with upstream, since I noticed there are still some C++ style
comments in your patchset.

2. Please consider adding socket diagnostics, see net/ipv4/inet_diag.c.

3. Please consider adding test cases, you can pretty much follow
tools/testing/vsock/vsock_test.c.

Regards,
Cong

