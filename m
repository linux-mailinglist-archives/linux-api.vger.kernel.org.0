Return-Path: <linux-api+bounces-2034-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3FB93F437
	for <lists+linux-api@lfdr.de>; Mon, 29 Jul 2024 13:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA3E41C2192D
	for <lists+linux-api@lfdr.de>; Mon, 29 Jul 2024 11:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88491146580;
	Mon, 29 Jul 2024 11:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A01ayMvn"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B357407A
	for <linux-api@vger.kernel.org>; Mon, 29 Jul 2024 11:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722253032; cv=none; b=Qr+zsg8UD7cpsQnmZbkrO2nhO/eFe1WE1QdVymsYsDSYXaZW4qN03DCEZM+CBiFeLIaAqX3tXbXdCD23+FEsPb4gY9zJ98oDHDgNgPQuM2u3O/WlFJpwxSLf6Xt8Ae6ED/up8sfMgLR8UidrIkNlarP0Dw41n8BNIlhvlD05S94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722253032; c=relaxed/simple;
	bh=d1eQ4ssNsC40NFMV3AiIXdST+OmypBvaqEVrV3I+FdQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=En/uF0Tuy0hCAKW/gMfuQtQhTrvw7AmqNHXEYo17/bNz1oh9FaLqV89+IDxgXVO2TjE4uWa6OOryXVo9cB520I0VQ55KbYlwGVMD9DjL4slK3qxk/SUZ7866Gs/K9g6KBipkGBzOXGFsFhcMc6NUJ8QY1to+o+1hPOBQ1vKJaqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A01ayMvn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722253029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2dgIjtdy9bxsyN5Iula/p7KGAXyxnKNn8eNDxdgyZ60=;
	b=A01ayMvnvJex7zD52p4mHnKObQhvJt2H2yHzSRwVHWHUMjMXzIFmIbSNrorRDGAc2yLew6
	gPfU4j6Sy6t06MlKOlrN6amnPX/vEBJV72H2BGij8IOqtG6x6XHyBGajuffTmrD02Ozir7
	9ElN+LYei5L0AuVde5lHjJgZHwuX/OQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-191-pFefaXg6M7uA4WgyIrOz2g-1; Mon,
 29 Jul 2024 07:37:06 -0400
X-MC-Unique: pFefaXg6M7uA4WgyIrOz2g-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9D23019560A1;
	Mon, 29 Jul 2024 11:37:05 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.45.224.31])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 18DF71955D42;
	Mon, 29 Jul 2024 11:37:02 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-api@vger.kernel.org,  Dave Chinner <dchinner@redhat.com>,
  Christian Brauner <brauner@kernel.org>
Subject: Re: Testing if two open descriptors refer to the same inode
In-Reply-To: <CAGudoHEBNRE+78n=WEY=Z0ZCnLmDFadisR-K2ah4SUO6uSm4TA@mail.gmail.com>
	(Mateusz Guzik's message of "Mon, 29 Jul 2024 13:06:28 +0200")
References: <874j88sn4d.fsf@oldenburg.str.redhat.com>
	<ghqndyn4x7ujxvybbwet5vxiahus4zey6nkfsv6he3d4en6ehu@bq5s23lstzor>
	<875xsoqy58.fsf@oldenburg.str.redhat.com>
	<vmjtzzz7sxctmf7qrf6mw5hdd653elsi423joiiusahei22bft@quvxy4kajtxt>
	<87sevspit1.fsf@oldenburg.str.redhat.com>
	<CAGudoHEBNRE+78n=WEY=Z0ZCnLmDFadisR-K2ah4SUO6uSm4TA@mail.gmail.com>
Date: Mon, 29 Jul 2024 13:36:59 +0200
Message-ID: <87cymwpgys.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

* Mateusz Guzik:

> On Mon, Jul 29, 2024 at 12:57=E2=80=AFPM Florian Weimer <fweimer@redhat.c=
om> wrote:
>>
>> * Mateusz Guzik:
>>
>> > On Mon, Jul 29, 2024 at 12:40:35PM +0200, Florian Weimer wrote:
>> >> * Mateusz Guzik:
>> >>
>> >> > On Mon, Jul 29, 2024 at 08:55:46AM +0200, Florian Weimer wrote:
>> >> >> It was pointed out to me that inode numbers on Linux are no longer
>> >> >> expected to be unique per file system, even for local file systems.
>> >> >
>> >> > I don't know if I'm parsing this correctly.
>> >> >
>> >> > Are you claiming on-disk inode numbers are not guaranteed unique per
>> >> > filesystem? It sounds like utter breakage, with capital 'f'.
>> >>
>> >> Yes, POSIX semantics and traditional Linux semantics for POSIX-like
>> >> local file systems are different.
>> >
>> > Can you link me some threads about this?
>>
>> Sorry, it was an internal thread.  It's supposed to be common knowledge
>> among Linux file system developers.  Aleksa referenced LSF/MM
>> discussions.
>>
>
> So much for open development :-P

I found this pretty quickly, so it does seem widely known:

  [LSF TOPIC] statx extensions for subvol/snapshot filesystems & more
  <https://lore.kernel.org/linux-fsdevel/2uvhm6gweyl7iyyp2xpfryvcu2g3padaga=
eqcbiavjyiis6prl@yjm725bizncq/>

>> It's certainly much easier to use than name_to_handle_at, so it looks
>> like a useful option to have.
>>
>> Could we return a three-way comparison result for sorting?  Or would
>> that expose too much about kernel pointer values?
>>
>
> As is this would sort by inode *address* which I don't believe is of
> any use -- the order has to be assumed arbitrary.

Doesn't the order remain valid while the files remain open?  Anything
else doesn't seem reasonable to expect anyway.

Thanks,
Florian


