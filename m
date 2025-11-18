Return-Path: <linux-api+bounces-5358-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B39C6A4BC
	for <lists+linux-api@lfdr.de>; Tue, 18 Nov 2025 16:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 782214F78B3
	for <lists+linux-api@lfdr.de>; Tue, 18 Nov 2025 15:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01655363C6D;
	Tue, 18 Nov 2025 15:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="LyTWWGQq"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884B43624CC
	for <linux-api@vger.kernel.org>; Tue, 18 Nov 2025 15:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763479151; cv=none; b=u9r3jO4KEW65WXeM8iDNdCQB2F9Y6wrxx2FMhSeP6i34U3cymLUv4wF/TgQqkxxuNIunsaBw60EltvZTYoWnBS9zsTvkxCqy648XbN0PA+ACKB3JOKjW668/ywpEc3UpCmzDVgtiRV0Fy7Atxn1Ow/FISczCaktthSX75TMrVKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763479151; c=relaxed/simple;
	bh=hk0ZXs9FzwYps2jxvQYT5vEXRk0C4Qe8Vs15fTPcizc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WPPJfkOrucXrWf/8VSqQoJPs6IoINITO15xB1QMFGZdmEmILHyC596MihjpVUFRb5oB3v3rh0OwEL3KZqUJ5VZjRZ3hrdPgTtqPDOTqbp2YsTbBtxLXtzSdxG4A4xLqH8GzERSIMin7b6qB2dm1HWmg6B5vjPK5dzOrf9O8ec+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=LyTWWGQq; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-644fcafdce9so1847888a12.1
        for <linux-api@vger.kernel.org>; Tue, 18 Nov 2025 07:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763479148; x=1764083948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hk0ZXs9FzwYps2jxvQYT5vEXRk0C4Qe8Vs15fTPcizc=;
        b=LyTWWGQq/MS5Oc5q/vluF3zrsa08FP9Mv9wwXDtpU4ZbuwWAMFtMVgoEBHN0LitWnL
         JkrHgRWceTDrk6qmuCuYbtXQ3OSCwW48EZWSN4NKMrRnzMhkRxxjYjdB0E2W3P2E9/ON
         F8MslExmuSsuKtEte6M6x92HyJ8CRtJownbcTOLCqLasBKKAoVmyXjiaI8Yoc9CJuHDB
         nVlNmbOXV2reLHYzOi5lXhQAX+BF5v9AYIaeatKRJzpDyLKOnaGYCxD4ttS5Qm6Mqb7C
         aVZB83HrAKwrlBZFJ8FMaqyoTN1I6Sais39TD9COrnagpvdycj9RsQr2APvmaxvFE+nl
         bcVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763479148; x=1764083948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hk0ZXs9FzwYps2jxvQYT5vEXRk0C4Qe8Vs15fTPcizc=;
        b=rydKjRyV7uKGh6oKZuGVcFSufZPzmS7Cb5wph7lSsJJbpYoQ8oC3m3Ct7w1B9tvMvT
         hQwflM1qL7886NFUa4JxoZEqm5txttDA/38BFYJ4AUUvJbnYsRx/IEUnmA1DbPSfv8sI
         t43OT1yuNpdBdIQ+8Pa6xKgGTPB/3IZsvYbKVYkjLgXTsnQSUmZXgFRjfksg8t7DBcq1
         1R8utmvC8mO1H+eZSEcg8wmPwD2P+uOWB0jvriQaM2dxIJgLavZkCf1zH05angkRPzUY
         Q2TikP7eXzh2IYD7FK+WAC8lrL2zbXBCyWGgMXaenl+ekGzEu4y965X6dFNP7MBkBd2a
         F/DA==
X-Forwarded-Encrypted: i=1; AJvYcCW56TW8/yi9ksUsHgpoQJjECN3bfjDVDPhs2DfglRZElANg2bp8DFv3rVDr1zpaxwWj8MMbzn2k0j0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3a4BrKMiF671tsU1eKAnQsSdrCffaDHqZ5iqD/R3j7Y6HKTSG
	GcBbtpnNSCOXVvhERkciwBFjDLDdA35IvLm6+LmXj9BqAJo4AeER9fOP8XaC36zQlZEQuwz8VIx
	b/e47lIfde0t6lFBPh9MZBc+Dxc/BcwTjEvw9+qxewA==
X-Gm-Gg: ASbGnctdrLEpbzyGmZSqOw1k0rHUcbmslNyxqqhgbOHjXlADEXRme7QrFdv1eYfKIuo
	dyOizwwaQLBKWPQ1aFV/nYk4NE9Hd8KNkuzTP8BEy/Mzjz1ZzMPo1QpJHpnofHcRlenJ6EZqJRg
	p+5C+wUC0+nSx/PCTGuQj7Dla9D+umrjgA8WyaSg40QptEByYAPB0CJRLhsDVtMb0bDxYLJ5KBr
	KHRTyfL0PuM6WvAlOTfiAOirTB18YCA8cEV8oRLmGkTemU1ULBDE7yoK6C+IaCNO/ge
X-Google-Smtp-Source: AGHT+IH73uaGXtkqWxA+vOqKSKXyc2f3xkXFQtsjUi4wNeWbkqpozwjKaxfRNk8v2eP437M4d3oprpw2Yh3MBItYnTs=
X-Received: by 2002:a05:6402:1d54:b0:641:9aac:e4a9 with SMTP id
 4fb4d7f45d1cf-64350e20d78mr16134284a12.15.1763479146917; Tue, 18 Nov 2025
 07:19:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
 <20251115233409.768044-3-pasha.tatashin@soleen.com> <aRnG8wDSSAtkEI_z@kernel.org>
 <CA+CK2bDu2FdzyotSwBpGwQtiisv=3f6gC7DzOpebPCxmmpwMYw@mail.gmail.com>
 <aRoi-Pb8jnjaZp0X@kernel.org> <CA+CK2bBEs2nr0TmsaV18S-xJTULkobYgv0sU9=RCdReiS0CbPQ@mail.gmail.com>
 <aRuODFfqP-qsxa-j@kernel.org> <CA+CK2bAEdNE0Rs1i7GdHz8Q3DK9Npozm8sRL8Epa+o50NOMY7A@mail.gmail.com>
 <aRxWvsdv1dQz8oZ4@kernel.org> <20251118140300.GK10864@nvidia.com> <aRyLbB8yoQwUJ3dh@kernel.org>
In-Reply-To: <aRyLbB8yoQwUJ3dh@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 18 Nov 2025 10:18:28 -0500
X-Gm-Features: AWmQ_bmBeX4hEJXb1SebGbQCukqm3GOn5m3ynIQiDheXLPwAAGR4LZnSH-Cy4rU
Message-ID: <CA+CK2bBFtG3LWmCtLs-5vfS8FYm_r24v=jJra9gOGPKKcs=55g@mail.gmail.com>
Subject: Re: [PATCH v6 02/20] liveupdate: luo_core: integrate with KHO
To: Mike Rapoport <rppt@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, pratyush@kernel.org, jasonmiu@google.com, 
	graf@amazon.com, dmatlack@google.com, rientjes@google.com, corbet@lwn.net, 
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, 
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org, 
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr, 
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com, 
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com, 
	vincent.guittot@linaro.org, hannes@cmpxchg.org, dan.j.williams@intel.com, 
	david@redhat.com, joel.granados@kernel.org, rostedt@goodmis.org, 
	anna.schumaker@oracle.com, song@kernel.org, linux@weissschuh.net, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	rafael@kernel.org, dakr@kernel.org, bartosz.golaszewski@linaro.org, 
	cw00.choi@samsung.com, myungjoo.ham@samsung.com, yesanishhere@gmail.com, 
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com, 
	aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	saeedm@nvidia.com, ajayachandra@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com, skhawaja@google.com, 
	chrisl@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 10:06=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wr=
ote:
>
> On Tue, Nov 18, 2025 at 10:03:00AM -0400, Jason Gunthorpe wrote:
> > On Tue, Nov 18, 2025 at 01:21:34PM +0200, Mike Rapoport wrote:
> > > On Mon, Nov 17, 2025 at 11:22:54PM -0500, Pasha Tatashin wrote:
> > > > > You can avoid that complexity if you register the device with a d=
ifferent
> > > > > fops, but that's technicality.
> > > > >
> > > > > Your point about treating the incoming FDT as an underlying resou=
rce that
> > > > > failed to initialize makes sense, but nevertheless userspace need=
s a
> > > > > reliable way to detect it and parsing dmesg is not something we s=
hould rely
> > > > > on.
> > > >
> > > > I see two solutions:
> > > >
> > > > 1. LUO fails to retrieve the preserved data, the user gets informed=
 by
> > > > not finding /dev/liveupdate, and studying the dmesg for what has
> > > > happened (in reality in fleets version mismatches should not be
> > > > happening, those should be detected in quals).
> > > > 2. Create a zombie device to return some errno on open, and still
> > > > study dmesg to understand what really happened.
> > >
> > > User should not study dmesg. We need another solution.
> > > What's wrong with e.g. ioctl()?
> >
> > It seems very dangerous to even boot at all if the next kernel doesn't
> > understand the serialization information..
> >
> > IMHO I think we should not even be thinking about this, it is up to
> > the predecessor environment to prevent it from happening. The ideas to
> > use ELF metadata/etc to allow a pre-flight validation are the right
> > solution.

100% agreed, this is the goal.

> > If we get into the next kernel and it receives information it cannot
> > process it should just BUG_ON and die, or some broad equivalent.

I initially had a panic() that would kill the kernel, but after
further consideration, I realized that we can still boot into
"maintenance" mode and allow the user to decide when and how to reboot
the machine back to a normal state.

Crashing during early boot has its own disadvantages: the crash kernel
is not available. Also, because live-update has to be very fast, the
console is likely to be disabled. Therefore, getting to userspace and
allowing the user to investigate what happened (e.g., automatically
retrieving dmesg or a core dump and filing a bug) before rebooting
seems like the most sensible approach.

This won't leak data, as /dev/liveupdate is completely disabled, so
nothing preserved in memory will be recoverable.

Pasha

