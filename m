Return-Path: <linux-api+bounces-3067-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7737AA163E3
	for <lists+linux-api@lfdr.de>; Sun, 19 Jan 2025 21:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D38F3A4B1D
	for <lists+linux-api@lfdr.de>; Sun, 19 Jan 2025 20:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699C21DF733;
	Sun, 19 Jan 2025 20:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ftb+2bU+"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA691974FE
	for <linux-api@vger.kernel.org>; Sun, 19 Jan 2025 20:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737318116; cv=none; b=HgiGsaKd6GjRfdQQv03twHmJovl4EKQTyiDB5LR8tpGp+7jwkOw+xqiK7K6wP/wI6OOsktyqfl1Yrem3cqDBcXwwN7QtiOunii7bWOvwl/7W/eekiys7mcffCmQHg6ccfysetP+24p6nwBhAaaolXya8l34z7FRSZEmLD+d9GgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737318116; c=relaxed/simple;
	bh=VOVgqnN4M5IlQgBcMoLP3AWiycBSbUVIa2m/GKsbXA8=;
	h=Date:From:Subject:To:Message-Id:MIME-Version:Content-Type; b=BpYgHkxnamfASmHWME/wvwvNwmSXInewukng7DtHREWRY3cM+uqSizPnlJNTD1AYKp3nlld/EUGti3QnQY8hwpeUg9QpFjhzEUtMe/0PmyikH1mfVnOwPVHzUU9EAsmVRcD0qSmBed33RjEgw/gt8vM9/Qxlrz/Nug/j9sz/tWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ftb+2bU+; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-38633b5dbcfso4208612f8f.2
        for <linux-api@vger.kernel.org>; Sun, 19 Jan 2025 12:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737318113; x=1737922913; darn=vger.kernel.org;
        h=mime-version:message-id:to:subject:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U14RaWCZrRO8LhLVsJ04zbkl0x7uQnhDodQAur7s/fs=;
        b=Ftb+2bU+qaNEwFrjrYhrdyqXrIUvEeQXw2/0Vvf+ZdpaBdCtYxdb0Ct/dFAc4qsApb
         +GS/G4asdtn9S43uvoxzLRInIq8rDiZYYGwdND87GGuUlbspHKXJrYUib8c3BWHvzgYY
         Y573TiLflIycB390szNDmq/JfevglC6or7l0WuCq2fATsJpMMeO/rJo9LFNgeYdFcs8k
         MJFwl4YIi5tWtrsxRQDfgnK9t7lj4rBjvLDgKddBEMS5GDtMmVF0fY8cMYP76+6sEhWW
         0BsoVy+bWfIb7YAPuzRugiFdiADvfx7sOq+ZRqc2Co1t6d1RnqC4/eZKtZ1+Q+OquySb
         fPvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737318113; x=1737922913;
        h=mime-version:message-id:to:subject:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U14RaWCZrRO8LhLVsJ04zbkl0x7uQnhDodQAur7s/fs=;
        b=XUjTkVwJbkVnteFvvwwxHgCearpr42+3HXj9r4pbIEcAn2x+xeLDcSLxn/BCXzYlG1
         w51TgQL6RYRtX/N0liJHWFdWW4T8bkVu7081EbiL/TDkTwGYh5gsaqHIDjcOUhuB85N1
         FcWhcXcxR4ynE/bqPxSWVLR85O+F7Wwal2mf7NsoccCYDNNPA+PHmVOZlInrfMSqwgp7
         ZECoNEtLhR/jlyUXgRGsGwlf59zD+uYn1qFpmL7Y+q7jwXjahuuhATlr1DzIT3r06wlw
         AgRly8xjFvUepaHZb2v7wXy03JSBgOvAVTwYIoBl2s+Zf7GhcRgpEYkUjBJF+F9Wo7s7
         YbEw==
X-Gm-Message-State: AOJu0YwjX3cq0bKsuSj/wLpHoMg4T+wP97UjQA3onOSiHYJ/Fu4jrqv0
	yQOSXug27X0BgFWE7PFKPcWoPcVlpwREMoKq/rR8RVL3cF6LwqtWWpxt8nnE
X-Gm-Gg: ASbGncuUH4QiH1o8Z26n5rkpxefBkedNcL9eCxZUkdOu4bAwLrd9Thlufg+enJUhalJ
	qs1Cpxckrh9jdL98uSRH3ilUKTEhPyTJwDFzLtNdiM4sAHK3wjzwPHdW75yWSrlJjCWm3h5kbnI
	enHPtfX0JNSu5WpKPZ0XIY7iO8hvRBh4E/BkQMucY71UcCI9UAiMFa0tAXBPogd5EN8sN0Z53lN
	4D5izP+O0MCDadnyL5/3QKxNK20MyKuSV/cpO+ERJ7PRA1hhDQYxGjGItpsPK1Ltg8LTBoyImOs
	Y8Qt9BvP50LrExm6HTweqdDES/R2aLrsfQF4m8E=
X-Google-Smtp-Source: AGHT+IGnJamO0LwlruAZF22GJTZd9e9ce7JRi+TlvVW90LMk7TQrkUj4VHZx7n4dPoA2m2yiWeHwhQ==
X-Received: by 2002:a5d:5f51:0:b0:385:e9de:d521 with SMTP id ffacd0b85a97d-38bf56494a0mr10118254f8f.8.1737318112564;
        Sun, 19 Jan 2025 12:21:52 -0800 (PST)
Received: from ?IPv6:2a02:a58:920d:7400:9154:f6c0:1f4c:b6bf? ([2a02:a58:920d:7400:9154:f6c0:1f4c:b6bf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf3221bf0sm8304643f8f.28.2025.01.19.12.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2025 12:21:51 -0800 (PST)
Date: Sun, 19 Jan 2025 22:21:45 +0200
From: mcaju95@gmail.com
Subject: [RFC] Extension to POSIX API for zero-copy data transfers
To: linux-api@vger.kernel.org, alx@kernel.org, serge@hallyn.com
Message-Id: <98RCQS.25Q70IQZ9KFA1@gmail.com>
X-Mailer: geary/46.0
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed

Greetings,

I've been thinking about a POSIX-like API that would allow 
read/write/send/recv to be zero-copy instead of being buffered. As 
such, storage devices and network sockets can have data transferred to 
and from them directly to a user-space application's buffers.

My focus was initially on network stacks and I drew inspiration from 
DPDK. I'm also aware of some work underway on extending io_uring to 
support zero copy.

A draft API would work as follows:
* The application fills-out a series of iovec's with buffers in its own 
memory that can store data from protocols such as TCP or UDP. These 
iovec's will serve as hints that will tell the network stack that it 
can definitely map a part of a frame's contents into the described 
buffers. For example, an iovec may contain { .iov_base = 0x4000, 
.iov_len = 0xa000 }. In this case, the data payload may end-up anywhere 
between 0x4000 and 0xe000 and after the syscall, its fields will be 
overwritten to something like { .iov_base = 0x4036, .iov_len = 1460 }
* In order to receive packets, the application calls readv or a 
readv-like syscall and its array of iovec will be modified to point to 
data payloads. Given that their pages will be mapped directly to 
user-space, some header fields or tail-room may have to be zero-ed out 
before being mapped, in order to prevent information leaks. Anny array 
of iovec's passed to one such readv syscall should be checked for 
sanity such as being able to hold data payloads in corner cases, not 
overlap with each-other and hold values that would prove to map pages 
to.
* The return value would be the number of data payloads that have been 
populated. Only the first such elements in the provided array would 
end-up containing data payloads.
* The syscall's prototype would be quite identical to that of readv, 
except that iov would not be a const struct iovec *, but just a struct 
iovec * and the return type would be modified. Like so:
  int zc_readv(int fd, struct iovec *iov, int iovcnt);

* In the case of write's a struct iovec may not suffice as the provided 
buffers should not only provide the location and size of data to be 
sent, but also the guarantee that the buffers have sufficient head and 
tail room. A hackish syscall would look like so:
  int zc_writev(int fd, const struct iovec (*iov)[2], int iovcnt);
* While the first iovec should describe the entire memory area 
available to a packet, including enough head and tail room for headers 
and CRC's or other fields specific to the NIC, the second should 
describe a sub-buffer that holds the data to be written.
* Again, sanity checks should be performed on the entire array, for 
things like having enough room for other fields, not overlapping, 
proper alignment, ability to DMA to a device, etc.
* After calling zc_writev the pages associated with the provided 
iovec's are immediately swapped for zero-pages to avoid data-leaks.
* For writes, arbitrary physical pages may not work for every NIC as 
some are bound by 32bit addressing constrains on the PCIe bus, etc. As 
such the application would have to manage a memory pool associated with 
each file-descriptor(possibly NIC) that would contain memory that is 
physically mapped to areas that can be DMA'ed to the proper devices. 
For example one may mmap the file-descriptor to obtain a pool of a 
certain size for this purpose.

This concept can be extended to storage devices, unfortunately I am 
unfamiliar with NVMe and SCSI so I can only guess that they work in a 
similar manner to NIC rings, in that data can be written and read to 
arbitrary physical RAM(as allowed by the IOMMU). Syscalls similar to 
zc_read and zc_write can be used on file descriptors pointing to 
storage devices to fetch or write sectors that contain data belonging 
to files. Some data should be zeroed-out in this case as well, as 
sectors more often that not will contain data that does not belong to 
the intended files.

For example one can mix such syscalls to read directly from storage 
into NIC buffers, providing in-place encryption on the way(via TLS) and 
send them to a client in a similar way that Netflix does with in-kernel 
TLS and sendfile.

All the best,
Mihai




