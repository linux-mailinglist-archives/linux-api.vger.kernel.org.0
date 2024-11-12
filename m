Return-Path: <linux-api+bounces-2712-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 012E69C4E8C
	for <lists+linux-api@lfdr.de>; Tue, 12 Nov 2024 07:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 986D7B255D2
	for <lists+linux-api@lfdr.de>; Tue, 12 Nov 2024 06:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8446E209698;
	Tue, 12 Nov 2024 06:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="Ca6IyZV2"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79941AB51B
	for <linux-api@vger.kernel.org>; Tue, 12 Nov 2024 06:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731391660; cv=none; b=tO1IoZ+ndZsrebgJ8IfucQYRszGNwjYLHKsLudCqLoRU0L7fzZ5YDDjIyPYVP+gDp67o2pI/evwnJokzWfqFpSFM5X5RhxiV0WBcLQ8mLaZR8WC7AWhsu7TrqUn62dV+SbI9eRuLk5V7IopSUZHC2kuplsPkLI3owGZo+BX0aRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731391660; c=relaxed/simple;
	bh=HSSpRUipMW20W37gQgejeBC1IMdeD5SipzvCc712ZUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=p+q3J6n4QmqkHdhyeh2o3D24+4xk50ptnqxDX6h8tzjSrApSvEhaACADf/6ID9wlgS/6tAb3B4lH4RACB8AU5hLRscLoWWCLz+kgW14Ys/E2hgg7qjq0iIePXKefye0FSLatzBee9AlFTGaNhfA5sR7qLx/oBQXgoLs75ijQs4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=Ca6IyZV2; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4vj1juVKO6JIxLcx7XG3zsiOpBQ6vtavRd9Ajn3aqmI=; t=1731391658; x=1732255658; 
	b=Ca6IyZV2RnfLe/hjNEmDGIhWJSGi7BZy+Vqn6z0EJ9TrD+98kTGqAcr6RAchTXA3Ed9tdLSXLma
	ybs6HcGLewWlLzBkF+auRnNr5cbANA5V78VXnnS4GorMGHTswm9Zal3Zo83Vpjkt8tkeH6sNDRuE2
	cFZBobfaQszIWIoerntp5r+sm/e0AakTv7wWR0iXumfpZZk/O0J5KV4e6S9RaBZE0pweJ7cJgN65v
	KzdANVzbNxdx7SRu/U5B4p9EE8/GxkvINdD3wXSy+Fk2XwTxKO291ihEjhPWEKX7EVYCo0J+5aOkB
	rNXVVq/MetoY5Pg5l6rteLoJ9xkwR4NcNX1A==;
Received: from mail-oo1-f54.google.com ([209.85.161.54]:60570)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tAk3s-0007Uj-TZ; Mon, 11 Nov 2024 22:07:38 -0800
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5ee461f5dedso2980218eaf.0;
        Mon, 11 Nov 2024 22:07:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVx77vAbKYO7+gYBzPVR6d33FlggFXueq0s/+jwjBTyB3VqfZ5yuq4c+aIll0zPchMlvcpHiqW8p3g=@vger.kernel.org, AJvYcCWOBd28YntwD0ldockS2e7Xx3wT88liQPlVj/WVHHhAY/TJWfe+NI7jaV5vzVUToOVCe/Hbg8yv@vger.kernel.org
X-Gm-Message-State: AOJu0YwW+S6OcWi1nOoiYC9XUVbZHFdX3nScuvIyoJA/MLloINilgF1v
	54er6Ci/QQLlX7OqKcyvdfIFXONmONrRxLewnexLSNZQzcojWr+vES3aDlKy0erNx1aNeXoBylW
	tVr37pjW4y23MESZI6rqSabAlNK4=
X-Google-Smtp-Source: AGHT+IFQ2r+8xJHpW6/R4rHXsAhjApdcTQZurg1j13zO66i4Kxj5GDZqwKk4kdEFYyMWMqWfJJ6IAYEYTRSLE7DhuSg=
X-Received: by 2002:a05:6820:8c8:b0:5eb:75a9:3aac with SMTP id
 006d021491bc7-5ee57c61091mr9368477eaf.6.1731391656295; Mon, 11 Nov 2024
 22:07:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111234006.5942-1-ouster@cs.stanford.edu> <ZzKeCJZoEIFoiJyO@LQ3V64L9R2>
In-Reply-To: <ZzKeCJZoEIFoiJyO@LQ3V64L9R2>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Mon, 11 Nov 2024 22:06:59 -0800
X-Gmail-Original-Message-ID: <CAGXJAmwM8zrkEZPZF4jbo-yatvcm4DOUYYh8C6bctvYX=eS+qA@mail.gmail.com>
Message-ID: <CAGXJAmwM8zrkEZPZF4jbo-yatvcm4DOUYYh8C6bctvYX=eS+qA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 00/12] Begin upstreaming Homa transport protocol
To: Joe Damato <jdamato@fastly.com>, John Ousterhout <ouster@cs.stanford.edu>, netdev@vger.kernel.org, 
	linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: dcedbbeaec314583a5a6d4e37e27e533

On Mon, Nov 11, 2024 at 4:15=E2=80=AFPM Joe Damato <jdamato@fastly.com> wro=
te:
>
> Quick note for future versions:
>
> Consider adding a changelog to the cover letter and to the
> individual patches which change from revision to revision to make
> it easier for folks to follow along with what changed.

Oops, sorry for the omission. I'll get this right in v3 and beyond. In
the meantime, here is the changelog for v2:

- Remove sockaddr_in_union declaration from public API in homa.h
- Remove kernel wrapper functions (homa_send, etc.) from homa.h
- Fix many sparse warnings (still more work to do here) and other issues
  uncovered by test robot
- Fix checkpatch.pl issues
- Remove residual code related to unit tests
- Remove references to tt_record from comments
- Make it safe to delete sockets during homa_socktab scans
- Use uintptr_t for portability fo 32-bit platforms
- Use do_div instead of "/" for portability
- Remove homa->busy_usecs and homa->gro_busy_usecs (not needed in
  this stripped down version of Homa)
- Eliminate usage of cpu_khz, use sched_clock instead of get_cycles
- Add missing checks of kmalloc return values
- Remove "inline" qualifier from functions in .c files
- Document that pad fields must be zero
- Use more precise type "uint32_t" rather than "int"
- Remove unneeded #include of linux/version.h

> You can find more information about this here:
> https://www.kernel.org/doc/html/v6.11/process/submitting-patches.html#res=
pond-to-review-comments
>
> And it might be helpful to take a look at other series on the list
> which have multiple revisions [1] to get a sense of how others
> typically do this.
>
> [1]: https://lore.kernel.org/netdev/20241030-feature_ptp_netnext-v19-0-94=
f8aadc9d5c@bootlin.com/

