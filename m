Return-Path: <linux-api+bounces-895-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D662F84E714
	for <lists+linux-api@lfdr.de>; Thu,  8 Feb 2024 18:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8023D1F24C71
	for <lists+linux-api@lfdr.de>; Thu,  8 Feb 2024 17:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9B282D8F;
	Thu,  8 Feb 2024 17:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I314OgUw"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BB082D80
	for <linux-api@vger.kernel.org>; Thu,  8 Feb 2024 17:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707414490; cv=none; b=VC9FsB/CAzMzqeZ5EyCyxlDTFducW2FSBLmtvl2oxfZ67+kyNHnMhay0mXM1ZfvlvD9QyEZSNOsux+jP+kVePOoRcJc+FPP+HxpORXP4oFV6bcnlc73P9AhKXXDmycHM+Mb3Ui6gFAkt5STOQmkFjDF0ZV8YtsfKYWy0j3sx4sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707414490; c=relaxed/simple;
	bh=z4H3q+V584X3cloLoQL4z7W9A39ryrm0xdBvifZpO/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P2pcO/D02ZF4wkgJhBLQtsrbBmTxa2kHfE3TSUfpjgI88W1zfUvMs1TE7/4O6+tRtQs3zEAwb75QSEObpKExq4bRwPx94JwANWiwSWbqZEQMaNlyeJ5SSmTMKSc/GmnROhmW0Hv+2NWL29x1snF/rOyHD++wO4/G76JHltuVg/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I314OgUw; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56037115bb8so15644a12.0
        for <linux-api@vger.kernel.org>; Thu, 08 Feb 2024 09:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707414487; x=1708019287; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S2CdXbb7WVGaal0hzp3f8lJdjgHwhFUuWNRhD/Ru7SU=;
        b=I314OgUwNasim2y3Bv0LjVyVJWpF9z9HVY4Ut50y6BCu5UZKylGtEd5f7GVRLWr3wH
         aOhD8srKNPfAY2lAQTbZ/eLFTBvuojpaHZdEcpDHplyUr+ssx7BPiU87zI3Rh3PIdoML
         7MwkiWm2QnItoSwuzx7NO5Pd8lK4NdlzpuLzb9VZeXS9mOdBQeGDkhX3GhmhK1DcdIzv
         TnNwnur2vp+D2KLESJFhKs845jicVEiJB8TXpivqRoqvBXxCEm2T0c2xxyX29Dob8RaB
         rjYmIuibPORxTVn5ImgfXr901CD3y0JTVSAwxNeXIkFexkq8/RnuuNXqS+dPWshQx8LR
         zBDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707414487; x=1708019287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S2CdXbb7WVGaal0hzp3f8lJdjgHwhFUuWNRhD/Ru7SU=;
        b=a094x299kknhjryDgHOiaUprrIFvOQwJAkYHoDPnNyTZImJ0SgkOAMxvUNTTwdN6Au
         hhvZYK3YOSs96lVA74j2r9RsN7okPrXgTyv2/Q5AtzHERJInLaSYS84ApUEbwwwbJ7po
         qJ27daczfbF2HNVWxPuAc4JdICX8hjCAJ5d0VYtnd9RqO09G0XWx5+NZ+ymfHGQCQZAP
         QXSV50yiubiMNDtSMQilwe9WoOcYOtpLZmlB1Isd7Ub3nayxfyYYHmjm0tKB+T2TOJey
         bcVS4qUAJAUbaobPHLej3F/e6zk2eQ1Tqog5I/E/RraNafSxCfMFNiSlcFz/UhV4QZUf
         L/LA==
X-Gm-Message-State: AOJu0Yy4N/DWmGzx5nyet6ccT40YE5ZVy/HW2MfBhoT7iPAFCBlBa56V
	k+ezuFqBQGtStdyEtk5pXPvD788IrEuWP7cY1EN/98BM49D9HU1pbqRK68XccuIAe7heaQNFSh8
	CezjotUoNbiVlw644OcbrIgqWHXntX4aCF7A+
X-Google-Smtp-Source: AGHT+IFx6D9+1QvqcwypiSW4MNJJCbBsNotpLlHoiufV7R69opJf1sckm7W6l77vtmstilA8dQaKIFFUNabofjpkE64=
X-Received: by 2002:a50:9e45:0:b0:55f:a1af:bade with SMTP id
 z63-20020a509e45000000b0055fa1afbademr418410ede.4.1707414487236; Thu, 08 Feb
 2024 09:48:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205210453.11301-1-jdamato@fastly.com> <20240205210453.11301-3-jdamato@fastly.com>
 <20240207110429.7fbf391e@kernel.org>
In-Reply-To: <20240207110429.7fbf391e@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 8 Feb 2024 18:47:54 +0100
Message-ID: <CANn89iKVoGUKZSBHanZ8zksmpnnysH1jng4KMgGpaqoyrP06Aw@mail.gmail.com>
Subject: Re: [PATCH net-next v6 2/4] eventpoll: Add per-epoll busy poll packet budget
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
> On Mon,  5 Feb 2024 21:04:47 +0000 Joe Damato wrote:
> > When using epoll-based busy poll, the packet budget is hardcoded to
> > BUSY_POLL_BUDGET (8). Users may desire larger busy poll budgets, which
> > can potentially increase throughput when busy polling under high networ=
k
> > load.
> >
> > Other busy poll methods allow setting the busy poll budget via
> > SO_BUSY_POLL_BUDGET, but epoll-based busy polling uses a hardcoded
> > value.
> >
> > Fix this edge case by adding support for a per-epoll context busy poll
> > packet budget. If not specified, the default value (BUSY_POLL_BUDGET) i=
s
> > used.
>
> Reviewed-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

