Return-Path: <linux-api+bounces-3032-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D05A143B9
	for <lists+linux-api@lfdr.de>; Thu, 16 Jan 2025 22:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12596188DB9E
	for <lists+linux-api@lfdr.de>; Thu, 16 Jan 2025 21:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A039F1D7E41;
	Thu, 16 Jan 2025 21:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ujuGrXhr"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B594B1D6187
	for <linux-api@vger.kernel.org>; Thu, 16 Jan 2025 21:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737061684; cv=none; b=IJ4PArvPd04Vw7TqNxCJXsuNbRoBL7kjG1tlTjd6hwZ3Tcez90AnaP7GAnmtEfVOC/HI52DX2dVOT3YaZ+y5W1oaog1x3XNlzsFMCzyy0AjrTE4PsfphZXXk25VNNMl0inF8azCyOzdftVVMu60Zhz06+vQ7OT6MexqK3WxPAnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737061684; c=relaxed/simple;
	bh=cFCXo5aRHUNgTON+50o3HQPg1dnwOvOkVIemCmVQ8f8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cRCm0dB//io1r9lcJeraNYbm1JKIj73ZIbQiK25RcQmC4GZzJLy+qpSK/M/6L9jKSdFgPQbNCVAbmxbNk027p8+3XYyWO2PxG4SAqr8eMfm2rqmqtJ/3/eN2oXgxSOvCMMEAZ4nA1KQpt44DywgO7AMNsRgkXnktKSrED8XEvJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ujuGrXhr; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-216281bc30fso32603405ad.0
        for <linux-api@vger.kernel.org>; Thu, 16 Jan 2025 13:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1737061682; x=1737666482; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QYbPqa4RiaKO/hTBkhTc15dnfxRHVJkFjnysbuWDQxU=;
        b=ujuGrXhrCbldyc+pwnJd1IceuKeEfNnhBo8Kogcksn5aE8OBesjRSATTV2bUKQnzdm
         dk9XyFKdkqbQ+Qf4alKvbyY8OXb/CzeaUeTCN0eTBZXUydCj8KQgYUjabZxb+O/UPSdm
         B5mqU+UVGcjfff5RPzl2nvjBaVKMp4yApeXNwvceRIJtSjEeY2E4RDZVf9yFqSeaOUHL
         2XjdoxVjXBeb9NlYwjEpcjCsxwR3UFRryyc2PuSq/MZc3pIWtwgwhpUJ7THLz0N9Mjwk
         7RpY9+MeGvg7k24daMGRAaxbB0dgi2H/OjIBaBn8rL5oNhdJlboVl8TKpgcqbyaRwH0Y
         b3uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737061682; x=1737666482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QYbPqa4RiaKO/hTBkhTc15dnfxRHVJkFjnysbuWDQxU=;
        b=OanrNerqEAVoUUZ1T/ve8A4TuPjZCVjiK12m0NabSiAwcr+sOGyswpAL5WO0+AaRNu
         kPOBYLg6a2Ua8c2petiGA/hHCzGtfjvQIPMgLERNWpTXvAF3jifucqCX44DfMZohpe6F
         tx289ZVkrbp0Bk8VQr/zu6rKWGkKTHb4ohNBeiEb2JhXU3lkewI6qw8wh0CLGm5zBbpg
         JtsTVrMxbgXf+mBaY32ZG6NppexgNsDIx0+3f2Ja6oaC/N+lWmUg1UhJDkXOci+Lz4kH
         MSCJblZFL2PHBTpPhAdrl8XQOMu8a9c1kEkDl4fg6OLjlgmv48Oisz38KR9SmW7ELhdM
         pUjA==
X-Forwarded-Encrypted: i=1; AJvYcCWqsrwXQiUuvkZwlovkzRhWN3dJdEXWvTtvg3/DP4rubvA1F7dg8/QQ7zhD8ifxvRYLx6h6oabzqLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/U+05cTZ8DN4trqV+xWbjEzCXYAi1vo8Fsq5u01JOx569shwY
	Lull7oKIYYcLeCOj95SNoJEDy8mW/PKcL7do0Kb2J3d60xabpCFdIo2KU7J/3A7lEW3SdXDm5Vm
	QFxU=
X-Gm-Gg: ASbGncs9t+uApCZ/5sWskosHZPz0W5/aSo1TLtSjwFhyONuDY9GxFWrDB4cFXnsQMxc
	B+PE11mCocTC0X1S94szAbN38mZegJiHujwEdI45Xzea5pU6ZSpQGjQklYkM8LPpBCmGsPSiybf
	htO0b12C9hsGs9DCQUpzDhhAIZZ2p4ZAGJKV+9mRTQJffruclxtjdcUA44cMPKbIGqUKYxwYaTV
	rYPt0oSR3z/qva6QNbL1OvzqhGeYNcrSakxPNWOEULXhyY=
X-Google-Smtp-Source: AGHT+IFjDytlvcL7R5uQyvD6/d+hRUPwU3v5GzGwrdH86L/g1oC0ZqcMzxtSZiqKwpSVhCo7eZNW3Q==
X-Received: by 2002:a17:902:e74c:b0:215:7719:24f6 with SMTP id d9443c01a7336-21c355cac95mr2790395ad.23.1737061682064;
        Thu, 16 Jan 2025 13:08:02 -0800 (PST)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2ceb8358sm4331645ad.71.2025.01.16.13.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 13:08:01 -0800 (PST)
Date: Thu, 16 Jan 2025 13:07:59 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: "Dmitry V. Levin" <ldv@strace.io>
Cc: Oleg Nesterov <oleg@redhat.com>,
	Eugene Syromyatnikov <evgsyr@gmail.com>,
	Mike Frysinger <vapier@gentoo.org>,
	Renzo Davoli <renzo@cs.unibo.it>,
	Davide Berardi <berardi.dav@gmail.com>,
	strace-devel@lists.strace.io, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org
Subject: Re: [PATCH v2 6/7] ptrace: introduce PTRACE_SET_SYSCALL_INFO request
Message-ID: <Z4l1L4OLoN7-lTkD@ghost>
References: <20250113170925.GA392@strace.io>
 <20250113171208.GF589@strace.io>
 <Z4hnEzFUgN9N0pSF@ghost>
 <20250116083328.GA32173@strace.io>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116083328.GA32173@strace.io>

On Thu, Jan 16, 2025 at 10:33:28AM +0200, Dmitry V. Levin wrote:
> On Wed, Jan 15, 2025 at 05:55:31PM -0800, Charlie Jenkins wrote:
> > On Mon, Jan 13, 2025 at 07:12:08PM +0200, Dmitry V. Levin wrote:
> [...]
> > > +	/* Changing the type of the system call stop is not supported. */
> > > +	if (ptrace_get_syscall_info_op(child) != info.op)
> > 
> > Since this isn't supported anyway, would it make sense to set the
> > info.op to ptrace_get_syscall_info_op(child) like is done for
> > get_syscall_info? The usecase I see for this is simplifying when the
> > user doesn't call PTRACE_GET_SYSCALL_INFO before calling
> > PTRACE_SET_SYSCALL_INFO.
> 
> struct ptrace_syscall_info.op is a field that specifies how to interpret
> the union fields of the structure, so if "op" is ignored, then the
> kernel would infer the meaning of the structure specified by the userspace
> tracer from the kernel state of the tracee.  This looks a bit too
> error-prone to allow.  For example, nothing good is expected to happen
> if syscall entry information is applied in a syscall exit stop.

Yes that's a good point. 

> 
> The tracer is not obliged to call PTRACE_GET_SYSCALL_INFO to set
> struct ptrace_syscall_info.op.  If the tracer keeps track of ptrace stops
> by other means, it can assign the right value by itself.
>
> And, btw, the comment should say "is not currently supported",
> I'll update it in the next iteration.
> 
> An idea mentioned in prior discussions was that it would make sense to
> specify syscall return value along with skipping the syscall in seccomp stop,
> and this would require a different value for "op" field, but
> I decided not to introduce this extra complexity yet.

Makes sense, thank you!

- Charlie

> 
> 
> -- 
> ldv

