Return-Path: <linux-api+bounces-4606-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7FDB3634F
	for <lists+linux-api@lfdr.de>; Tue, 26 Aug 2025 15:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 758252A735B
	for <lists+linux-api@lfdr.de>; Tue, 26 Aug 2025 13:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9097B252904;
	Tue, 26 Aug 2025 13:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RtMVJbu5"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB74C139579
	for <linux-api@vger.kernel.org>; Tue, 26 Aug 2025 13:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756214274; cv=none; b=D/0MX6hK3wLMvFOzBrTHwJlFU9t2i4ImEeCk8H1+7S2V/WX1Wo0NjAqN+09SZa35mAYJK0DT7yQujlucym5O5/qIhrGW0gZ6b038K/qepr8x19I6m319PjnFYFDnb5ibk/feIV8wm+vy7wtsH5zEX6AkhygNOLidLyeFJ3hjVtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756214274; c=relaxed/simple;
	bh=y4N61BlKpZ+I/7MpvmFjSG/RwJx2LLP/CDwW83KIYLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nXGbq8BLIi6i7Lj9XN9QO5R6G7OL28LxjS3ExVHQkvqDtb29o80jlkh8mH3zvJkY+e1ofsZqWIYUcZBx4VT263sAqUTSGYaDBUkYwiRG7Fc2qs7IQiRDqBCl9/Fx+V/y/ScYyR2MmNm3HuIJu/ti0pNGRxczujmfGjEzBCvfOoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RtMVJbu5; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b47475cf8ecso3922606a12.0
        for <linux-api@vger.kernel.org>; Tue, 26 Aug 2025 06:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756214272; x=1756819072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s2waiyY68eSnONzZAIpbu2N+cpYMagRhbCM4VyS1SkA=;
        b=RtMVJbu5wv4SzSo8C45sng10h8T+T6dqUS7d2iMpjBfcG+T9sklMWcTxTpyNTP7+yZ
         tT7+3axLLsyY2LB6iQPhN/hGF6+i+WZQscxsG3Co0/h2j0Lkq9F1vAtZxO6qS9Snhwaq
         klDsKYsmdukee0TKe/pw9wVte0tOll7v7ZScZA4lQ8qw5t42SU/G8tPpuGIq+HBdOKwn
         qTEivKA3TAt+Uo04jf+mPM/OMIT0BOxdYbtq9Pxcy2vnWV6I99tjiVYcO4cidZhb7I5C
         YM2xKwzvHSdKE+r1BOSsxUjMSTKRu0fD8NI62MNMom7wNh/auchBMRzyCBSkgOGWyE1X
         aAwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756214272; x=1756819072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s2waiyY68eSnONzZAIpbu2N+cpYMagRhbCM4VyS1SkA=;
        b=drWERlx6V7zwI0GxFXMP8zM0XB9sKNrp+8ulJQof6F8JRMYCCDmvWI0f9OEqidvjiC
         Znr1EyH14ao6fkknPiDKT76Rza0lWBoDrWEbNqlofdZwthYlZ3nPrrSvtdlXQOhZ6w99
         52hj54PhHcLpvl503P0RiIJDp5YGzx4v4aHdOeYN9gWR2GMNNwZt88R/U505uezOZU0r
         O7hmNAsdwHvKnsWlwBDJ4S9ue5Zq/zoyAnBVQb6oIpZ5Vl0B5/4oM4s2x1AmN1pLXmZI
         a3x+aw45vqLjGlbW9GaQnhuT6eOrOwzJUrOzl1lKn3jX7JBq/ejOp1M/ZZpETkxlQ//4
         Jm6A==
X-Gm-Message-State: AOJu0YxmuFK3aYz08c6l29GRPiYWmuSu+e6EGcwiJ+VYmyC7OzGnjzZs
	52LBJNAB815rG9UPfictgJmY/lBXiTMZJ87yeUexd/9bb3XLMCbE82/mTBK1XgPaJxiZKiYdopO
	onSALRHy8qeZpHKBfOXnqDoygbFVRYyPtMq2S
X-Gm-Gg: ASbGncuKN70YyL/MEuTQvYEXdDCqAdqY/rNw7A4xUxxG1YkHf41uplBvweI7FW82jCT
	umB4muQS4w9DTwUdSHz82wma/yGA7oJfEDKJl43WKsOXe9fhQUWltZ48lCfxaTkr8xS2bq/W24T
	DdXM8vTVdezoYBaq2Gnmq3nrHZcBH6300Kq9HwkHYwGBfdbwIKvbd3yqJSI6p+sDi6JtUf08xtd
	YS0a3d5GVxN0CLkgQ0hDo6/BMH3LO7zPjdCX6uYig==
X-Google-Smtp-Source: AGHT+IF/3dfNGHcFA7mkNvSuUqjR1KQ7FFneiaH2hxJi6opZwc9gr4Mznd6AirnAJX5pPJXi756ZYJ+qe2/kPMzYY9w=
X-Received: by 2002:a17:902:dad1:b0:242:9bc6:63c3 with SMTP id
 d9443c01a7336-2462efaa3b8mr218200045ad.54.1756214271826; Tue, 26 Aug 2025
 06:17:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <98RCQS.25Q70IQZ9KFA1@gmail.com> <aK2rRYT+FXe6BvwC@mail.hallyn.com>
In-Reply-To: <aK2rRYT+FXe6BvwC@mail.hallyn.com>
From: =?UTF-8?Q?Mihai=2DDrosi_C=C3=A2ju?= <mcaju95@gmail.com>
Date: Tue, 26 Aug 2025 16:17:40 +0300
X-Gm-Features: Ac12FXziV6qBLXD_qPKBzF6iSuDxePyHDcBsoMEPpVJ_mKaioVo6loxhd5syLp0
Message-ID: <CALznt_mjdW6B4ru18EBssHhA_a2k4YWhWV9yY27rhiKWPygoAg@mail.gmail.com>
Subject: Re: [RFC] Extension to POSIX API for zero-copy data transfers
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-api@vger.kernel.org, alx@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 3:40=E2=80=AFPM Serge E. Hallyn <serge@hallyn.com> =
wrote:
>
> On Sun, Jan 19, 2025 at 10:21:45PM +0200, mcaju95@gmail.com wrote:
> > Greetings,
> >
> > I've been thinking about a POSIX-like API that would allow
> > read/write/send/recv to be zero-copy instead of being buffered. As such=
,
> > storage devices and network sockets can have data transferred to and fr=
om
> > them directly to a user-space application's buffers.
>
> Hi Mihai,
>
> You're proposing a particular API.  Do you have a kernel side
> implementation of something along these lines?  Do you have a particular
> user space use case of your own in mind, or have you spoken to any
> potential users?
>
I have a user-space implementation based on DPDK, it has a different and
less hackish API than the one presented here. I thought it best to seek
feedback from the Linux community before actually writing code for the kern=
el.

The use-case is the same as the normal Berkley sockets API.
Except that it's faster because you don't copy buffers between kernel and
user-space on each send and recv. You can even receive a buffer that
will be written to disk or vice-versa. Thereby making obsolete KTLS, etc.

I have not spoken to potential users, but I am aware of several attempts
at a zero copy TCP/IP stack F-Stack, mTCP, io_uring.

> > My focus was initially on network stacks and I drew inspiration from DP=
DK.
> > I'm also aware of some work underway on extending io_uring to support z=
ero
> > copy.
>
> I've not really been following io_uring work.  Can you summarize the
> status of their zero copy support and the advantages that this new
> API would bring?
>

So far, io_uring only supports zero copy reception of TCP segments
https://docs.kernel.org/networking/iou-zcrx.html
it's rather cluttered...

> thanks,
> -serge
>
> > A draft API would work as follows:
> > * The application fills-out a series of iovec's with buffers in its own
> > memory that can store data from protocols such as TCP or UDP. These iov=
ec's
> > will serve as hints that will tell the network stack that it can defini=
tely
> > map a part of a frame's contents into the described buffers. For exampl=
e, an
> > iovec may contain { .iov_base =3D 0x4000, .iov_len =3D 0xa000 }. In thi=
s case,
> > the data payload may end-up anywhere between 0x4000 and 0xe000 and afte=
r the
> > syscall, its fields will be overwritten to something like { .iov_base =
=3D
> > 0x4036, .iov_len =3D 1460 }
> > * In order to receive packets, the application calls readv or a readv-l=
ike
> > syscall and its array of iovec will be modified to point to data payloa=
ds.
> > Given that their pages will be mapped directly to user-space, some head=
er
> > fields or tail-room may have to be zero-ed out before being mapped, in =
order
> > to prevent information leaks. Anny array of iovec's passed to one such =
readv
> > syscall should be checked for sanity such as being able to hold data
> > payloads in corner cases, not overlap with each-other and hold values t=
hat
> > would prove to map pages to.
> > * The return value would be the number of data payloads that have been
> > populated. Only the first such elements in the provided array would end=
-up
> > containing data payloads.
> > * The syscall's prototype would be quite identical to that of readv, ex=
cept
> > that iov would not be a const struct iovec *, but just a struct iovec *=
 and
> > the return type would be modified. Like so:
> >  int zc_readv(int fd, struct iovec *iov, int iovcnt);
> >
> > * In the case of write's a struct iovec may not suffice as the provided
> > buffers should not only provide the location and size of data to be sen=
t,
> > but also the guarantee that the buffers have sufficient head and tail r=
oom.
> > A hackish syscall would look like so:
> >  int zc_writev(int fd, const struct iovec (*iov)[2], int iovcnt);
> > * While the first iovec should describe the entire memory area availabl=
e to
> > a packet, including enough head and tail room for headers and CRC's or =
other
> > fields specific to the NIC, the second should describe a sub-buffer tha=
t
> > holds the data to be written.
> > * Again, sanity checks should be performed on the entire array, for thi=
ngs
> > like having enough room for other fields, not overlapping, proper align=
ment,
> > ability to DMA to a device, etc.
> > * After calling zc_writev the pages associated with the provided iovec'=
s are
> > immediately swapped for zero-pages to avoid data-leaks.
> > * For writes, arbitrary physical pages may not work for every NIC as so=
me
> > are bound by 32bit addressing constrains on the PCIe bus, etc. As such =
the
> > application would have to manage a memory pool associated with each
> > file-descriptor(possibly NIC) that would contain memory that is physica=
lly
> > mapped to areas that can be DMA'ed to the proper devices. For example o=
ne
> > may mmap the file-descriptor to obtain a pool of a certain size for thi=
s
> > purpose.
> >
> > This concept can be extended to storage devices, unfortunately I am
> > unfamiliar with NVMe and SCSI so I can only guess that they work in a
> > similar manner to NIC rings, in that data can be written and read to
> > arbitrary physical RAM(as allowed by the IOMMU). Syscalls similar to zc=
_read
> > and zc_write can be used on file descriptors pointing to storage device=
s to
> > fetch or write sectors that contain data belonging to files. Some data
> > should be zeroed-out in this case as well, as sectors more often that n=
ot
> > will contain data that does not belong to the intended files.
> >
> > For example one can mix such syscalls to read directly from storage int=
o NIC
> > buffers, providing in-place encryption on the way(via TLS) and send the=
m to
> > a client in a similar way that Netflix does with in-kernel TLS and send=
file.
> >
> > All the best,
> > Mihai
> >
> >
> >

