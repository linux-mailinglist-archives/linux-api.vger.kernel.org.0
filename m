Return-Path: <linux-api+bounces-3795-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73136ABA483
	for <lists+linux-api@lfdr.de>; Fri, 16 May 2025 22:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54F53A25FDA
	for <lists+linux-api@lfdr.de>; Fri, 16 May 2025 20:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE8225E80D;
	Fri, 16 May 2025 20:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="DiMXWn8E";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="PCxkMDEy"
X-Original-To: linux-api@vger.kernel.org
Received: from mx.wizmail.org (smtp.wizmail.org [85.158.153.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA39A22B8AA;
	Fri, 16 May 2025 20:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.158.153.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747426245; cv=none; b=rAlsjTl0Uwdf15zXZwTQh66CRx4tPuoqZDEaB9WzrGQxMnCP/7puhCC4IGXCiJMCnzK4JF/GdhbYMIzxp3NBbHwVAy4NWF7y/1S54ogEbpfVL7MjVyNVw9eg3V0nVVbvBUusrbzU0FT9WQSOoSATmA/oa+sLLCw8jj0r946NRlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747426245; c=relaxed/simple;
	bh=MzQCKlZ6ntcYLkjp6eVbxjn94XdvNoNwLedvn9sSeyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kGueK6o50ReRbduMH5z/p3UHhMHO9Ytv9d0YXB63p2Qal/JzQk49MG59gBIpkAH1OQecvjMV44oB6jk2sBDrCNhhw65na+cKb8cONRk1ro+NzHc+6kK0KIh3YfwXk0SYo8HL3l91IZd8wg8ybnY2wdiCPxjtUE66l3x4+u0Beso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exim.org; spf=fail smtp.mailfrom=exim.org; dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=DiMXWn8E; dkim=pass (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=PCxkMDEy; arc=none smtp.client-ip=85.158.153.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exim.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=exim.org
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
	d=wizmail.org; s=e202001; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive:Autocrypt;
	bh=2u/wuQYqYyn1Vldm9yAljhV51VyW7Grx7RCI3jbqeFE=; b=DiMXWn8EQAH5f4qBi2qu4wW2za
	C55OP8yn6LIz+42J6kgjQjHtXJHMyae3oGcdL3io9odijpPUfYboN3dFeeDA==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wizmail.org
	; s=r202001; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Sender:Reply-To:
	Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive:Autocrypt;
	bh=2u/wuQYqYyn1Vldm9yAljhV51VyW7Grx7RCI3jbqeFE=; b=PCxkMDEy3+RfINVsiOYIpq2of1
	OMeE/KRzZ9l5il99QCVp5LrglVzyLUBh2iPB5LT0AEKcsCbHCGw45YUI3l/HEKxU8hcnw7lhcMKZZ
	NxwbYdCsqXyf9kFoygKr1L0PcDUcb6bvvQ+JdKWsGfXIptWtFc9AkHulbcS8j56OH6v53O7JsnZSF
	MCYgNK4Dz2tINbUuVFMMeUNVV1qzIEdAgb/Ce1//HFcAifcVsHNlxPiVDIZo1EW/mCuu3e3aGS/Y4
	hJ+DQztSYzRtx3ace/h611eBoQhk1EH98UxpHx8htWwad3SzjEuIyuKMDVfRj+F3IjwM7IHbTe2St
	HYlnWH7g==;
Authentication-Results: wizmail.org;
	iprev=pass (hellmouth.gulag.org.uk) smtp.remote-ip=85.158.153.62;
	auth=pass (PLAIN) smtp.auth=jgh@wizmail.org
Received: from hellmouth.gulag.org.uk ([85.158.153.62] helo=[192.168.0.17])
	by wizmail.org (Exim 4.98.115)
	(TLS1.3) tls TLS_AES_128_GCM_SHA256
	with esmtpsa
	id 1uG1OB-000000079Uj-3PDd
	(return-path <jgh@exim.org>);
	Fri, 16 May 2025 20:10:39 +0000
Message-ID: <ff23f425-536c-43b7-b536-58d99e61f2f8@exim.org>
Date: Fri, 16 May 2025 21:10:39 +0100
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] tcp: support preloading data on a listening socket
To: Neal Cardwell <ncardwell@google.com>
Cc: netdev@vger.kernel.org, linux-api@vger.kernel.org, edumazet@google.com
References: <cover.1747409911.git.jgh@exim.org>
 <CADVnQymxsOGLnUfurhDLXNUaK4gpaYm2zTDEWRxy8JPqH6O6vg@mail.gmail.com>
Content-Language: en-GB
From: Jeremy Harris <jgh@exim.org>
In-Reply-To: <CADVnQymxsOGLnUfurhDLXNUaK4gpaYm2zTDEWRxy8JPqH6O6vg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Pcms-Received-Sender: hellmouth.gulag.org.uk ([85.158.153.62] helo=[192.168.0.17]) with esmtpsa

Hi Neal,

Thanks for the initial review.


On 2025/05/16 7:19 PM, Neal Cardwell wrote:
> On Fri, May 16, 2025 at 11:55 AM Jeremy Harris <jgh@exim.org> wrote:
>>
>> Support write to a listen TCP socket, for immediate
>> transmission on passive connection establishments.
>>
>> On a normal connection transmission is triggered by the receipt of
>> the 3rd-ack. On a fastopen (with accepted cookie) connection the data
>> is sent in the synack packet.
>>
>> The data preload is done using a sendmsg with a newly-defined flag
>> (MSG_PRELOAD); the amount of data limited to a single linear sk_buff.
>> Note that this definition is the last-but-two bit available if "int"
>> is 32 bits.
> 
> Can you please add a bit more context, like:
> 
> + What is the motivating use case? (Accelerating Exim?)

Accelerating any server-first ULP, SMTP being the major use I
know of (and yes, Exim is my primary testcase and is operational
against a test kernel with this patch series).

One caveat: the initial server data cannot change from one passive
connection to another.

> Is this
> targeted for connections using encryption (like TLS/SSL), or just
> plain-text connections?

TLS-on-connect cannot benefit, being client-first.  SMTP that uses
STARTTLS can take advantage of it, as can plaintext SMTP.

I would not expect https to be able to use it.


> + What are the exact performance improvements you are seeing in your
> benchmarks that (a) motivate this, and (b) justify any performance
> impact on the TCP stack?

Because of the lack of userland roundtrip needed for the initial server
data, there is a latency benefit.  This is better for the TFO-C case,
but also significant for the non-TFO case.

Packet capture (laptop, loopback, TFO-C case) for initial SYN to first
client data packet (5 samples):

- baseline   TFO_C      1064 1470 1455 1547 1595  usec
- patched    non-TFO     140  150  159  144  153  usec
- patched    TFO_C       142  149  149  125  125  usec



One fewer packet is sent by the server in most packet captures, sometimes
one fewer in each direction.  There is one less application kernel entry/exit
on the server.

I'm hoping those differences will add up to both less cpu time (on both
endpoints) and less wire-time.  However, I have not run benchmarks looking
for a change in peak rate of connection-handling.



In summary, this is the mirror of TCP Fast Open client data: the latency
benefit is probably the most useful aspect.


> + Regarding "Support write to a listen TCP socket, for immediate
> transmission on passive connection establishments.": can you please
> make it explicitly clear whether the data written to the listening
> socket is saved and transmitted on all future successful passive
> sockets that are created for the listener,

This.  The data is copied for each future passive socket from this
listener,

> or is just transmitted on
> the next connection that is created?

(and not this option).




I'll copy these comments in any future v2.
As Eric says, I should run KASAN/syzbot first.

-- 
Cheers,
   Jeremy

