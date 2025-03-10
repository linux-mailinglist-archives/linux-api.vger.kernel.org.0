Return-Path: <linux-api+bounces-3382-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFA4A589F0
	for <lists+linux-api@lfdr.de>; Mon, 10 Mar 2025 02:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41CBE3AB23B
	for <lists+linux-api@lfdr.de>; Mon, 10 Mar 2025 01:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E00F1386C9;
	Mon, 10 Mar 2025 01:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=easton24.com header.i=@easton24.com header.b="eOFREPaM";
	dkim=permerror (0-bit key) header.d=easton24.com header.i=@easton24.com header.b="RWh3Me9e"
X-Original-To: linux-api@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC9613665A;
	Mon, 10 Mar 2025 01:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741569993; cv=pass; b=ZgoBNTf/BKSURT8HXmQ6FNP9lmB0SOK2gTlVb4poQpym6ycK0R6GnZtfb7DmdetAouRmNsQj+HRXOLL2st86ouW7E+2YGrRF6Bpeh78Xw42wHPXjwTViPlTe0Z7PJptYYRvffxa5+L93Baewp6H0oGJAwo0xzVoWZSCgWoOyWLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741569993; c=relaxed/simple;
	bh=6LcUOq1hsssE0AqRUxZ4BniuRgVh9NdUQjba4V7/EWM=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=lw6O6CO9AKeM9mi7/BCSB3r7bF9x+nUwaPytqV27BB2DR/50Z9oJdi4Ky1EgEthk7aMbTNHNjUbyXnveVuRhVhmynmqQI/qANbPy6vbBa93mpqtOhDTWela7s1W1Vy+H2nWX6yfap4kLc+9aauR49BKhk8/hmahCxTA/Cj/whdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Easton24.com; spf=none smtp.mailfrom=Easton24.com; dkim=pass (2048-bit key) header.d=easton24.com header.i=@easton24.com header.b=eOFREPaM; dkim=permerror (0-bit key) header.d=easton24.com header.i=@easton24.com header.b=RWh3Me9e; arc=pass smtp.client-ip=85.215.255.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Easton24.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=Easton24.com
ARC-Seal: i=1; a=rsa-sha256; t=1741569630; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ChQ45vhM7fOaKAdsFiKygSzwf4xOuzOyUe2/oa1iiJTBbkNgNDtRiir7vZSZc2iPYw
    bjhZTo2adfcQ0YV3+EQ0Q/PCvZPQeZaUrXsurlKI8qB9Q23eZ+x/nNB3BYRR7T0iwqOy
    1bM8tAVxPinKFjv9SAA4x8/dmuOXCr6raPHdtsMHJlUaKdwro4p+GmtA4ew81dOpnn2y
    Yk1AkbyWyl/dr9ry6u9pbNQN7jJonB+p6Hr5CF5G3xNJ9r4YX4Dx+liE/49Kc9t8XBHV
    8EJW8pU+0g0YktMJUpofZrKq6FfAJ0UDSYb6LXAglceVoFNMSHwnBm+lRgAsnC2HgdiM
    2AoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1741569630;
    s=strato-dkim-0002; d=strato.com;
    h=To:Cc:Date:Message-Id:Subject:From:Cc:Date:From:Subject:Sender;
    bh=foheYkXrwXKKl4Rr4rMkTYq3SLuUiYrTDo1SChphCoY=;
    b=SYWgdKd1qxpS2miyiR49jG3XTWVvZFYVvbEShoS0PA58HoixjKMaB842jTISjErOo9
    3TFyH2keMrBWfAtfFDqpGFnnp9UsoCGDI8U6/R/IVauDMN2SasLk6tdrPunQjAslCHjh
    mdAFXl7S/4hj0QZfLTssn/w0HvF0LBrQI0j6hIKfdF92+WA0o7VuMx+gXjI35RabfK4o
    96I07nVlbv7lIcwMcORIvm8iRVyQnKvbi09NuuL7qVjdMz0arMBFDUhFpHBbGR7RkHK3
    CSwSu5psESIQiratcApOom5MqTYukAe6uvIpOpdxZeRx0fBc0SNc7485Gc9JDqeA3Z3A
    oLLg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1741569630;
    s=strato-dkim-0002; d=easton24.com;
    h=To:Cc:Date:Message-Id:Subject:From:Cc:Date:From:Subject:Sender;
    bh=foheYkXrwXKKl4Rr4rMkTYq3SLuUiYrTDo1SChphCoY=;
    b=eOFREPaMvyhjEnLB2Rw0eQWMG+fVpwjCLez86K9dOW6Sr5eiatYlQfpmUTqS9AaXCv
    d58KbuXnHC/3rmW+aGZPeXHwdX8v1Miy0zLpGIjTh8oyj6t5gDu12otHd9sDb5F8vjkE
    D0HuZ3CgnhVBxqd6Z2yQ8iuKfHdhZfp+GUbctdrFK9HfEiQKZFjoHfXI61WmGNGPYlsH
    SWC1QkeQ/jQLFskBmLo8bJU9B9HbYNNAuzJzO7zTcl3xXdbN2l1S9JXPEjvBEaoJ4SYB
    ag0UHqZXaoVm1F8GgzOmlXmvA264tjZ1nKDDaDmM+cEUhi/VPHOYyg9UjetzELyTJwuM
    /M1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1741569630;
    s=strato-dkim-0003; d=easton24.com;
    h=To:Cc:Date:Message-Id:Subject:From:Cc:Date:From:Subject:Sender;
    bh=foheYkXrwXKKl4Rr4rMkTYq3SLuUiYrTDo1SChphCoY=;
    b=RWh3Me9eJOuZO2sajQ4M5tPnnkb9eRv7sOy2uPuoU7e53k5EOsUmP+xqpu29DlPPDK
    6Q3Am9o7dOHVxsiwM7AQ==
X-RZG-AUTH: ":LWIAZ0W/W/pq1lnu7xBnWI9dcLAVag9Fw0GNvwqoTn1xxmSLPleFxWEArEE0GYFlYsAk"
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id j29bd512A1KSJNz
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Mon, 10 Mar 2025 02:20:28 +0100 (CET)
From: Andrew Easton <Andrew@Easton24.com>
Content-Type: multipart/mixed;
	boundary="Apple-Mail=_753246C6-9D01-46E3-BB53-F273F77C40D3"
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6.1.9\))
Subject: Add sysctl for tcp_delayed_ack
Message-Id: <FC9BF302-0724-49F3-AD7C-6761D65024A1@Easton24.com>
Date: Sun, 9 Mar 2025 20:20:14 -0500
Cc: Simon Horman <horms@kernel.org>,
 "Linux Kernel Mailing List, Network Subsystem" <netdev@vger.kernel.org>,
 "Linux Kernel Mailing List, Sysctl API ABI" <linux-api@vger.kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
 "David S. Ahern" <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
X-Mailer: Apple Mail (2.3731.700.6.1.9)
Content-Transfer-Encoding: 7bit


--Apple-Mail=_753246C6-9D01-46E3-BB53-F273F77C40D3
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

Subject: Add sysctl for tcp_delayed_ack

Hi everyone, 

this is a proposed patch for adding a sysctl for
disabling TCP delayed ACK (IETF RFC 1122)  without
having to patch software to constantly poke sockets
with TCP_QUICKACK which apparently resets on
subsequent operations, see tcp(7).

For my personal computer networks experimenting with
globally disabling TCP delayed ACK across two other
operating systems seems to have considerably improved
congestion control.  (While I propose only anecdotal
evidence, there is more to it.  Am open to the
ensuing technical discussion, but only if that turns
out to be a good use of other people's time.)

This is my first proposed kernel patch and it is
likely missing a whole bunch of details.  For
example:

1. Where is the TCP ACK delay computed for IPv6?
Could not identify this in file net/ipv6/tcp_ipv6.c .

2. Perhaps, adding kernel configuration options for
the ncurses interface is desireable.  What is a good
example to learn from?

3. Perhaps, setting constants in file
include/uapi/linux/sysctl.h may be unnecessary, but I
have not found any guidelines on when these CTL
numbers are necessary.  Likely, because I did not
read the documentation carefully enough.  Any
pointers are appreciated.

4. The default should probably be a value like
net.ipv4.tcp_delayed_ack=1 that preserves the current
behavior and hence is backwards compatible for user
space.  A value of net.ipv4.tcp_delayed_ack=0 should
globally (for IPv4) disable TCP delayed ACK.  Would
also like to add the option for IPv6, but see point
(1).


In case a similar sysctl has already been proposed
and rejected in the past, please point me to the
mailing list archives, if that is not too
inconvenient.


Which questions have I failed to ask that I should
have asked?

Errors and lack of research are on me.

Thank you for sharing your time.

Andrew




--Apple-Mail=_753246C6-9D01-46E3-BB53-F273F77C40D3
Content-Disposition: attachment;
	filename=0001-Add-sysctl-net.ipv4.tcp_delayed_ack-for-disabling-TC.patch
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="0001-Add-sysctl-net.ipv4.tcp_delayed_ack-for-disabling-TC.patch"
Content-Transfer-Encoding: quoted-printable

=46rom=205e92e3f9dafe58d363b433356f5d6ca1c9e14aba=20Mon=20Sep=2017=20=
00:00:00=202001=0AFrom:=20Andrew=20Easton=20<Andrew@Easton24.com>=0A=
Date:=20Sun,=209=20Mar=202025=2019:52:28=20-0500=0ASubject:=20[PATCH]=20=
Add=20sysctl=20net.ipv4.tcp_delayed_ack=20for=20disabling=20TCP=20=
delayed=0A=20acknowledgements=20from=20IETF=20RFC=201122.=0A=0A---=0A=20=
.../networking/net_cachelines/netns_ipv4_sysctl.rst=20=20|=20=201=20+=0A=20=
include/net/netns/ipv4.h=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20|=20=201=20+=0A=20=
include/net/netns/ipv6.h=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20|=20=201=20+=0A=20=
include/uapi/linux/sysctl.h=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20|=20=202=20++=0A=20=
net/core/net_namespace.c=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20|=20=202=20++=0A=20=
net/ipv4/sysctl_net_ipv4.c=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20|=2012=20++++++++++++=0A=20=
net/ipv4/tcp_input.c=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20|=20=203=20++-=0A=20=
net/ipv6/tcp_ipv6.c=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20|=20=205=20+++++=0A=208=20=
files=20changed,=2026=20insertions(+),=201=20deletion(-)=0A=0Adiff=20=
--git=20a/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst=20=
b/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst=0Aindex=20=
de0263302f16..88eaed807c94=20100644=0A---=20=
a/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst=0A+++=20=
b/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst=0A@@=20=
-110,6=20+110,7=20@@=20int=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20sysctl_tcp_min_rtt_wlen=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20rea=0A=20u8=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20sysctl_tcp_min_tso_segs=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
unlikely(icsk_ca_ops-written)=0A=20u8=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
sysctl_tcp_tso_rtt_log=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20read_mostly=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20tcp_tso_autosize=0A=20u8=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20sysctl_tcp_autocorking=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20read_mostly=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
tcp_push/tcp_should_autocork=0A+u8=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
sysctl_tcp_delayed_ack=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20read_mostly=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20tcp_in_quickack_mode=0A=20u8=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20sysctl_tcp_reflect_tos=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
tcp_v(4/6)_send_synack=0A=20int=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
sysctl_tcp_invalid_ratelimit=0A=20int=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
sysctl_tcp_pacing_ss_ratio=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
default_cong_cont(tcp_update_pacing_rate)=0Adiff=20--git=20=
a/include/net/netns/ipv4.h=20b/include/net/netns/ipv4.h=0Aindex=20=
46452da35206..5777f95af02e=20100644=0A---=20a/include/net/netns/ipv4.h=0A=
+++=20b/include/net/netns/ipv4.h=0A@@=20-59,6=20+59,7=20@@=20struct=20=
netns_ipv4=20{=0A=20=09u8=20sysctl_tcp_tso_win_divisor;=0A=20=09u8=20=
sysctl_tcp_tso_rtt_log;=0A=20=09u8=20sysctl_tcp_autocorking;=0A+=09u8=20=
sysctl_tcp_delayed_ack;=0A=20=09int=20sysctl_tcp_min_snd_mss;=0A=20=09=
unsigned=20int=20sysctl_tcp_notsent_lowat;=0A=20=09int=20=
sysctl_tcp_limit_output_bytes;=0Adiff=20--git=20=
a/include/net/netns/ipv6.h=20b/include/net/netns/ipv6.h=0Aindex=20=
5f2cfd84570a..ec8b891e09ca=20100644=0A---=20a/include/net/netns/ipv6.h=0A=
+++=20b/include/net/netns/ipv6.h=0A@@=20-56,6=20+56,7=20@@=20struct=20=
netns_sysctl_ipv6=20{=0A=20=09u8=20skip_notify_on_dev_down;=0A=20=09u8=20=
fib_notify_on_flag_change;=0A=20=09u8=20icmpv6_error_anycast_as_unicast;=0A=
+=09u8=20tcp_delayed_ack;=0A=20};=0A=20=0A=20struct=20netns_ipv6=20{=0A=
diff=20--git=20a/include/uapi/linux/sysctl.h=20=
b/include/uapi/linux/sysctl.h=0Aindex=208981f00204db..669b3775bd31=20=
100644=0A---=20a/include/uapi/linux/sysctl.h=0A+++=20=
b/include/uapi/linux/sysctl.h=0A@@=20-426,6=20+426,7=20@@=20enum=0A=20=09=
NET_TCP_ALLOWED_CONG_CONTROL=3D123,=0A=20=09NET_TCP_MAX_SSTHRESH=3D124,=0A=
=20=09NET_TCP_FRTO_RESPONSE=3D125,=0A+=09NET_IPV4_TCP_DELAYED_ACK=3D126,=20=
/*=20TCP_QUICKACK=20but=20globally.=20*/=0A=20};=0A=20=0A=20enum=20{=0A=
@@=20-530,6=20+531,7=20@@=20enum=20{=0A=20=09NET_IPV6_IP6FRAG_TIME=3D23,=0A=
=20=09NET_IPV6_IP6FRAG_SECRET_INTERVAL=3D24,=0A=20=09=
NET_IPV6_MLD_MAX_MSF=3D25,=0A+=09NET_IPV6_TCP_DELAYED_ACK=3D26,=20/*=20=
TCP_QUICKACK=20but=20globally.=20*/=0A=20};=0A=20=0A=20enum=20{=0Adiff=20=
--git=20a/net/core/net_namespace.c=20b/net/core/net_namespace.c=0Aindex=20=
4303f2a49262..b101707ab9e4=20100644=0A---=20a/net/core/net_namespace.c=0A=
+++=20b/net/core/net_namespace.c=0A@@=20-1155,6=20+1155,8=20@@=20static=20=
void=20__init=20netns_ipv4_struct_check(void)=0A=20=09=09=09=09=20=20=20=20=
=20=20sysctl_tcp_tso_rtt_log);=0A=20=09=
CACHELINE_ASSERT_GROUP_MEMBER(struct=20netns_ipv4,=20netns_ipv4_read_tx,=0A=
=20=09=09=09=09=20=20=20=20=20=20sysctl_tcp_autocorking);=0A+=09=
CACHELINE_ASSERT_GROUP_MEMBER(struct=20netns_ipv4,=20netns_ipv4_read_tx,=0A=
+=09=09=09=09=20=20=20=20=20=20sysctl_tcp_delayed_ack);=0A=20=09=
CACHELINE_ASSERT_GROUP_MEMBER(struct=20netns_ipv4,=20netns_ipv4_read_tx,=0A=
=20=09=09=09=09=20=20=20=20=20=20sysctl_tcp_min_snd_mss);=0A=20=09=
CACHELINE_ASSERT_GROUP_MEMBER(struct=20netns_ipv4,=20netns_ipv4_read_tx,=0A=
diff=20--git=20a/net/ipv4/sysctl_net_ipv4.c=20=
b/net/ipv4/sysctl_net_ipv4.c=0Aindex=2042cb5dc9cb24..8aa00eee8247=20=
100644=0A---=20a/net/ipv4/sysctl_net_ipv4.c=0A+++=20=
b/net/ipv4/sysctl_net_ipv4.c=0A@@=20-28,6=20+28,8=20@@=20static=20int=20=
tcp_adv_win_scale_max=20=3D=2031;=0A=20static=20int=20tcp_app_win_max=20=
=3D=2031;=0A=20static=20int=20tcp_min_snd_mss_min=20=3D=20=
TCP_MIN_SND_MSS;=0A=20static=20int=20tcp_min_snd_mss_max=20=3D=2065535;=0A=
+static=20int=20tcp_delayed_ack_min=20=3D=200;=0A+static=20int=20=
tcp_delayed_ack_max=20=3D=20255;=0A=20static=20int=20=
ip_privileged_port_min;=0A=20static=20int=20ip_privileged_port_max=20=3D=20=
65535;=0A=20static=20int=20ip_ttl_min=20=3D=201;=0A@@=20-959,6=20+961,16=20=
@@=20static=20struct=20ctl_table=20ipv4_net_table[]=20=3D=20{=0A=20=09=09=
.mode=09=09=3D=200644,=0A=20=09=09.proc_handler=20=20=20=3D=20=
proc_allowed_congestion_control,=0A=20=09},=0A+=09{=0A+=09=09.ctl_name=09=
=3D=20NET_IPV4_TCP_DELAYED_ACK,=0A+=09=09.procname=09=3D=20=
"tcp_delayed_ack",=0A+=09=09.data=09=09=3D=20=
&init_net.ipv4.sysctl_tcp_delayed_ack,=0A+=09=09.maxlen=09=09=3D=20=
sizeof(u8),=0A+=09=09.mode=09=09=3D=200644,=0A+=09=09.proc_handler=20=20=20=
=3D=20proc_dou8vec_minmax,=0A+=09=09.extra1=09=09=3D=20=
&tcp_delayed_ack_min,=0A+=09=09.extra2=09=09=3D=20&tcp_delayed_ack_max=0A=
+=09},=0A=20=09{=0A=20=09=09.procname=09=3D=20"tcp_keepalive_time",=0A=20=
=09=09.data=09=09=3D=20&init_net.ipv4.sysctl_tcp_keepalive_time,=0Adiff=20=
--git=20a/net/ipv4/tcp_input.c=20b/net/ipv4/tcp_input.c=0Aindex=20=
0cbf81bf3d45..5c5e934816cd=20100644=0A---=20a/net/ipv4/tcp_input.c=0A+++=20=
b/net/ipv4/tcp_input.c=0A@@=20-334,7=20+334,8=20@@=20static=20bool=20=
tcp_in_quickack_mode(struct=20sock=20*sk)=0A=20=09const=20struct=20=
dst_entry=20*dst=20=3D=20__sk_dst_get(sk);=0A=20=0A=20=09return=20(dst=20=
&&=20dst_metric(dst,=20RTAX_QUICKACK))=20||=0A-=09=09=
(icsk->icsk_ack.quick=20&&=20!inet_csk_in_pingpong_mode(sk));=0A+=09=09=
(icsk->icsk_ack.quick=20&&=20!inet_csk_in_pingpong_mode(sk)=20||=0A+=09=09=
sk->sk_net.ipv4.sysctl_tcp_delayed_ack=20>=200);=0A=20}=0A=20=0A=20=
static=20void=20tcp_ecn_queue_cwr(struct=20tcp_sock=20*tp)=0Adiff=20=
--git=20a/net/ipv6/tcp_ipv6.c=20b/net/ipv6/tcp_ipv6.c=0Aindex=20=
2debdf085a3b..b040ceea9f22=20100644=0A---=20a/net/ipv6/tcp_ipv6.c=0A+++=20=
b/net/ipv6/tcp_ipv6.c=0A@@=20-1149,6=20+1149,11=20@@=20static=20void=20=
tcp_v6_send_ack(const=20struct=20sock=20*sk,=20struct=20sk_buff=20*skb,=20=
u32=20seq,=0A=20=09=09=09=20=20=20=20struct=20tcp_key=20*key,=20u8=20=
tclass,=0A=20=09=09=09=20=20=20=20__be32=20label,=20u32=20priority,=20=
u32=20txhash)=0A=20{=0A+=09/*=20Where=20=20does=20this=20condition=20=
need=20to=20go?=0A+=09=20*=20It=20doesn't=20seem=20clear=20where=20=
exactly=20the=0A+=09=20*=20TCP=20ACK=20is=20delayed=20(IETF=20RFC=20=
1122)=20for=0A+=09=20*=20IPv6.=0A+=09=20*=20=
(sk->net.ipv6.sysctl.tcp_delayed_ack=20>=200)=20*/=0A=20=09=
tcp_v6_send_response(sk,=20skb,=20seq,=20ack,=20win,=20tsval,=20tsecr,=20=
oif,=200,=0A=20=09=09=09=20=20=20=20=20tclass,=20label,=20priority,=20=
txhash,=20key);=0A=20}=0A--=20=0A2.48.0=0A=0A=

--Apple-Mail=_753246C6-9D01-46E3-BB53-F273F77C40D3
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii




--Apple-Mail=_753246C6-9D01-46E3-BB53-F273F77C40D3--

