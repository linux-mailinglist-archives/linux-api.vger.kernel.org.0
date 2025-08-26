Return-Path: <linux-api+bounces-4604-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E86BAB35F54
	for <lists+linux-api@lfdr.de>; Tue, 26 Aug 2025 14:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52D731BA21D1
	for <lists+linux-api@lfdr.de>; Tue, 26 Aug 2025 12:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4653E2C15A8;
	Tue, 26 Aug 2025 12:40:48 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEBD7464
	for <linux-api@vger.kernel.org>; Tue, 26 Aug 2025 12:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756212048; cv=none; b=kthS/regkb3CPFliyL9WyMnC7q2Gl+YTzARk+5+7XM9EAXKWq3HNNns0eJmvEbXkT/9WrRRpKEgD4U2hIIxxlRzXBHOL4xcSln84pKma4Nc4BHOAYkFDQVNcwYIf4OqZzaYc6NiYtglCmuHFuE/fV9CrFUwWAZOqOjiOWqIDUag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756212048; c=relaxed/simple;
	bh=QuJAvECEc1UuDTUnAv8iXVg20L01El9aQkSJDcJ9vS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=taz5KEMRWaWi3Qo1xhxQ60HFsFwRqZoeEhb7eUoQtbjrqJU/E4Cgz5IEIbBFDQqBzcUi23Lj19/R5i9M0FG4U502j4fmK4rB32EYrqBLlv2FBeilLVuHrzComUprMGONFJ1yP3XNkHu5HPzulnDppXKsTLt+3ajuvy6U46br03k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id A6610FEF; Tue, 26 Aug 2025 07:40:37 -0500 (CDT)
Date: Tue, 26 Aug 2025 07:40:37 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: mcaju95@gmail.com
Cc: linux-api@vger.kernel.org, alx@kernel.org, serge@hallyn.com
Subject: Re: [RFC] Extension to POSIX API for zero-copy data transfers
Message-ID: <aK2rRYT+FXe6BvwC@mail.hallyn.com>
References: <98RCQS.25Q70IQZ9KFA1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98RCQS.25Q70IQZ9KFA1@gmail.com>

On Sun, Jan 19, 2025 at 10:21:45PM +0200, mcaju95@gmail.com wrote:
> Greetings,
> 
> I've been thinking about a POSIX-like API that would allow
> read/write/send/recv to be zero-copy instead of being buffered. As such,
> storage devices and network sockets can have data transferred to and from
> them directly to a user-space application's buffers.

Hi Mihai,

You're proposing a particular API.  Do you have a kernel side
implementation of something along these lines?  Do you have a particular
user space use case of your own in mind, or have you spoken to any
potential users?

> My focus was initially on network stacks and I drew inspiration from DPDK.
> I'm also aware of some work underway on extending io_uring to support zero
> copy.

I've not really been following io_uring work.  Can you summarize the
status of their zero copy support and the advantages that this new
API would bring?

thanks,
-serge

> A draft API would work as follows:
> * The application fills-out a series of iovec's with buffers in its own
> memory that can store data from protocols such as TCP or UDP. These iovec's
> will serve as hints that will tell the network stack that it can definitely
> map a part of a frame's contents into the described buffers. For example, an
> iovec may contain { .iov_base = 0x4000, .iov_len = 0xa000 }. In this case,
> the data payload may end-up anywhere between 0x4000 and 0xe000 and after the
> syscall, its fields will be overwritten to something like { .iov_base =
> 0x4036, .iov_len = 1460 }
> * In order to receive packets, the application calls readv or a readv-like
> syscall and its array of iovec will be modified to point to data payloads.
> Given that their pages will be mapped directly to user-space, some header
> fields or tail-room may have to be zero-ed out before being mapped, in order
> to prevent information leaks. Anny array of iovec's passed to one such readv
> syscall should be checked for sanity such as being able to hold data
> payloads in corner cases, not overlap with each-other and hold values that
> would prove to map pages to.
> * The return value would be the number of data payloads that have been
> populated. Only the first such elements in the provided array would end-up
> containing data payloads.
> * The syscall's prototype would be quite identical to that of readv, except
> that iov would not be a const struct iovec *, but just a struct iovec * and
> the return type would be modified. Like so:
>  int zc_readv(int fd, struct iovec *iov, int iovcnt);
> 
> * In the case of write's a struct iovec may not suffice as the provided
> buffers should not only provide the location and size of data to be sent,
> but also the guarantee that the buffers have sufficient head and tail room.
> A hackish syscall would look like so:
>  int zc_writev(int fd, const struct iovec (*iov)[2], int iovcnt);
> * While the first iovec should describe the entire memory area available to
> a packet, including enough head and tail room for headers and CRC's or other
> fields specific to the NIC, the second should describe a sub-buffer that
> holds the data to be written.
> * Again, sanity checks should be performed on the entire array, for things
> like having enough room for other fields, not overlapping, proper alignment,
> ability to DMA to a device, etc.
> * After calling zc_writev the pages associated with the provided iovec's are
> immediately swapped for zero-pages to avoid data-leaks.
> * For writes, arbitrary physical pages may not work for every NIC as some
> are bound by 32bit addressing constrains on the PCIe bus, etc. As such the
> application would have to manage a memory pool associated with each
> file-descriptor(possibly NIC) that would contain memory that is physically
> mapped to areas that can be DMA'ed to the proper devices. For example one
> may mmap the file-descriptor to obtain a pool of a certain size for this
> purpose.
> 
> This concept can be extended to storage devices, unfortunately I am
> unfamiliar with NVMe and SCSI so I can only guess that they work in a
> similar manner to NIC rings, in that data can be written and read to
> arbitrary physical RAM(as allowed by the IOMMU). Syscalls similar to zc_read
> and zc_write can be used on file descriptors pointing to storage devices to
> fetch or write sectors that contain data belonging to files. Some data
> should be zeroed-out in this case as well, as sectors more often that not
> will contain data that does not belong to the intended files.
> 
> For example one can mix such syscalls to read directly from storage into NIC
> buffers, providing in-place encryption on the way(via TLS) and send them to
> a client in a similar way that Netflix does with in-kernel TLS and sendfile.
> 
> All the best,
> Mihai
> 
> 
> 

