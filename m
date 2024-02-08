Return-Path: <linux-api+bounces-896-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC7C84E725
	for <lists+linux-api@lfdr.de>; Thu,  8 Feb 2024 18:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAA59B2EABA
	for <lists+linux-api@lfdr.de>; Thu,  8 Feb 2024 17:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FD185C55;
	Thu,  8 Feb 2024 17:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wpwXr4iM"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4147B84FA4
	for <linux-api@vger.kernel.org>; Thu,  8 Feb 2024 17:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707414577; cv=none; b=u45/A5kee1+jxuHcm8T6q5AjizIrKHFhcp+D/VDia70lvK335hNBU1wGtHGXWWG33j08v7Lly5ROFl83xPMR5ZNaiat4S/5IJ2uOFQKOd4gtpN8VXmrUrYJyiuKVhhFn4PKqEYBI2EJcO2QVXYra0N5rp3d8oWKVJGsEPeYcLig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707414577; c=relaxed/simple;
	bh=zda74WXXHe+dpK7C/1O9euGmKfSWLYZHT6inIgr65PI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JJZaKA0nvi3PZUzZ8OMhwYb2/UfCL2IBqnInumURK101A6WVxhFmKOWQCdggjQhERqN/NOIkiSidXmxvHreO+29AyccY/YQsDtZC4cUWGGW1gzkxFiRCnsMLJUIN8kr1sUlfy/jRzhalF/FrD+4PnSAzUjozcDC1vzEnxGqMkLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wpwXr4iM; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40fd15fe6a8so87975e9.0
        for <linux-api@vger.kernel.org>; Thu, 08 Feb 2024 09:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707414574; x=1708019374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CCfiShFFpvtKtiBytNdjmOBh5smtgUcYd0nNspQ9STQ=;
        b=wpwXr4iMM2ZmAY9vuJlWMUTByLGQ09rbhpPMp49OFpUWFuBUEC5n5F4vTyDG5dZxQu
         lXPweZIr2v/bvCTf7MH2XFOGNP+cXL2dO/wXgRTSHacBexo5xadUSqxFq3CJ7nMdAPVS
         NjgIquP28LQLu7YLBJZzdhTNZ2B/k4JgVTS3F6H9Tc6iUG/6i0wIuA3+bbfIHELu0nky
         dSMbIb3CwyEDnqK/aZZMTJH6/YOTkipeOLYEsbQAnVKMyzJGTUliuhyDs4pjGP14BsbC
         15gzd8QflAHc3G5avRvEhONseNY1vLeH7SBeOqPhMqdqYzYLlZxHu44jYCkLywWoDgre
         0mcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707414574; x=1708019374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CCfiShFFpvtKtiBytNdjmOBh5smtgUcYd0nNspQ9STQ=;
        b=llG9P+XTXSCo9VxrPjVfoHwr4OLe54LM6PwE9I+qgD+bXM1Xyo0/p8uslENgn+Zm88
         YAHd4zmf7LdQnvS1tMTvDbi4IKld//ljpLOiqWyKp07/qmY610QTkhmfZxwdONaj4QqM
         l75CKHQzaIL2oFAYsGM4Z00fDCdXRe/viT3j2jqHiBMVvTWR2qt3nk5vz+77JclZjrwP
         OTbdlLKa6oXZljMxUpC4B83VSovq+Fq32RjTOw5zsJo6R88jVyLUGgUw0M/TSy2ZkA8S
         0FXqCSKD97Uow7jdZVpP4V36HaTddPNMvXA/ZJ4INZvbzM+lT7JUwFbLt/xCTvYcbbhR
         IsQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbR7lZ6OPo+n+ZepcPir5m2Z8Oh2nzOFLBLOteJbwpBCQkFABpx1I2l825H3700ifPAE1wsoXmDOKfhVj/pP0bDeEZO5XDIIin
X-Gm-Message-State: AOJu0Yw+tPvNtPV8LnNzkkMq5JePQBn1nnqgQP8YBEJ6cUHcjOdebW5b
	5Za/UWoo1WTdr4/UsTQ2TYDQjYNRlnxwxhGhU3OGZHFCCQgiWvDWg1PX5m74BPfOrAkbm0RNz6o
	rCO/QokJTKxUsWskJ0FGfgf7GTIVk8gLcrInJ
X-Google-Smtp-Source: AGHT+IEstkMTSitlbM4q+eTyETgEQ6arnNpmDwi2H2dhpRlCslml1hPB7df4QjwKC06oN3wleuc+F11zwRfxak+YwIg=
X-Received: by 2002:a05:600c:cc6:b0:410:3ce8:8386 with SMTP id
 fk6-20020a05600c0cc600b004103ce88386mr2420wmb.0.1707414574332; Thu, 08 Feb
 2024 09:49:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205210453.11301-1-jdamato@fastly.com> <20240205210453.11301-4-jdamato@fastly.com>
 <20240207110437.292f7eaf@kernel.org>
In-Reply-To: <20240207110437.292f7eaf@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 8 Feb 2024 18:49:23 +0100
Message-ID: <CANn89iLBROzWjTxr4wFyEuCmBj9zoRkEwMGOLxUAJA683paVSg@mail.gmail.com>
Subject: Re: [PATCH net-next v6 3/4] eventpoll: Add per-epoll prefer busy poll option
To: Jakub Kicinski <kuba@kernel.org>
Cc: Joe Damato <jdamato@fastly.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, chuck.lever@oracle.com, jlayton@kernel.org, 
	linux-api@vger.kernel.org, brauner@kernel.org, davem@davemloft.net, 
	alexander.duyck@gmail.com, sridhar.samudrala@intel.com, 
	willemdebruijn.kernel@gmail.com, weiwan@google.com, David.Laight@aculab.com, 
	arnd@arndb.de, sdf@google.com, amritha.nambiar@intel.com, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 8:04=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Mon,  5 Feb 2024 21:04:48 +0000 Joe Damato wrote:
> > When using epoll-based busy poll, the prefer_busy_poll option is hardco=
ded
> > to false. Users may want to enable prefer_busy_poll to be used in
> > conjunction with gro_flush_timeout and defer_hard_irqs_count to keep de=
vice
> > IRQs masked.
> >
> > Other busy poll methods allow enabling or disabling prefer busy poll vi=
a
> > SO_PREFER_BUSY_POLL, but epoll-based busy polling uses a hardcoded valu=
e.
> >
> > Fix this edge case by adding support for a per-epoll context
> > prefer_busy_poll option. The default is false, as it was hardcoded befo=
re
> > this change.
>
> Reviewed-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

