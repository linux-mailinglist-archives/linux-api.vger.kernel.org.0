Return-Path: <linux-api+bounces-5251-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A09A4C54174
	for <lists+linux-api@lfdr.de>; Wed, 12 Nov 2025 20:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EC4C3AF507
	for <lists+linux-api@lfdr.de>; Wed, 12 Nov 2025 19:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A60347BCA;
	Wed, 12 Nov 2025 19:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="OHm7Z9iz"
X-Original-To: linux-api@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF449F4F1;
	Wed, 12 Nov 2025 19:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762974755; cv=none; b=URys5gNQBpkW4wOLBg9QF63Qe9hVYOjw4pr6TVn1JWmandT72AQEYm2cGegAuvVdEW8Tx5lVfW0vNJwJAnBilIzuFwGvtaA9i0MOXFRhgpklnifUOZgaOBpDZR48CW+fTEbVg5wbYh7/H9WDY1kFNpoujgWGVkU45hZordFvrSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762974755; c=relaxed/simple;
	bh=jXC9bB4V8JZDHH8KkvEdlzzbXviJlukUYigxi/Z4NQM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Wny3RYZtFmU8XHPuiY+q3Gijo0dBVFIdZ4+/4oxW5bzDcwQYK1D074Fl7QzxyubFjv9ftpOniEzNox8szEeB/+g/LI9TNQRoxM1yDVmCulmFyhY1THziNRst+U+DVxHNOJrxtUvKYC7fxY4xK6Gom9h5YBmV5vPKrnUjvFi247U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=fail (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=OHm7Z9iz reason="signature verification failed"; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 5ACJCOjl947912
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 12 Nov 2025 11:12:25 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 5ACJCOjl947912
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025102301; t=1762974745;
	bh=KgKus8qyoixupr5452xdQSrweevbXqNfoayZTCiy+SY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=OHm7Z9iz0FfUWc6jyxxRqydIl5GomRIibwO2ZKAwzPv+VI5sB7XNT7qmhnpkD7Cr3
	 +AL8WJ1ikquzh03E/59AetaWZlvOFbvoDEsmVMXVXdap3D1YFCb35maRqco8q0IMwR
	 nVBwp/qjuJbhhny0tXwy4jrdgqaT+jllFgoQAmgty4kJt4TUIkmvBJd0SUXp1MlNvf
	 z5O/8hzhzVl61gH5PtIFtN8MDnnTfUtwu+lqWyxf91XIgnPQNzgV9mGTfFGaUQ9ME8
	 XAvYtdRokQc5rHP+jisw3nJhuaABGwE+sS23ZzYZGPD+WgXwsrzON8yJfmBFBuUBsg
	 ADJxYBWVIXpOQ==
Date: Wed, 12 Nov 2025 11:12:22 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "Theodore Ts'o" <tytso@mit.edu>, Maarten Brock <Maarten.Brock@sttls.nl>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: RFC: Serial port DTR/RTS - O_NRESETDEV
User-Agent: K-9 Mail for Android
In-Reply-To: <2025111241-domestic-moonstone-f75f@gregkh>
References: <dc42f5d4-a707-4442-bda6-1c1990666f54@zytor.com> <20251110033556.GC2988753@mit.edu> <ADB50E23-DC8B-43D0-A345-E10396A3DFD4@zytor.com> <AMBPR05MB11925DA076098B05E418BF64283CEA@AMBPR05MB11925.eurprd05.prod.outlook.com> <20251110201933.GH2988753@mit.edu> <0F8021E8-F288-4669-8195-9948844E36FD@zytor.com> <20251111035143.GJ2988753@mit.edu> <D4AF3E24-8698-4EEC-9D52-655D69897111@zytor.com> <2025111214-doily-anyway-b24b@gregkh> <6DBB5931-ACD4-4174-9FCE-96C45FFC4603@zytor.com> <2025111241-domestic-moonstone-f75f@gregkh>
Message-ID: <DD67C0CF-D330-4D40-B610-FD3EB7AA0218@zytor.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On November 12, 2025 8:46:50 AM PST, Greg KH <gregkh@linuxfoundation=2Eorg>=
 wrote:
>On Wed, Nov 12, 2025 at 08:09:45AM -0800, H=2E Peter Anvin wrote:
>> On November 12, 2025 3:22:56 AM PST, Greg KH <gregkh@linuxfoundation=2E=
org> wrote:
>> >On Mon, Nov 10, 2025 at 07:57:22PM -0800, H=2E Peter Anvin wrote:
>> >> Honestly, though, I'm far less interested in what 8250-based hardwar=
e does than e=2Eg=2E USB=2E
>> >
>> >hahahahahahaha {snort}
>> >
>> >Hah=2E  that's a good one=2E
>> >
>> >Oh, you aren't kidding=2E
>> >
>> >Wow, good luck with this=2E  USB-serial adaptors are all over the plac=
e,
>> >some have real uarts in them (and so do buffering in the device, and
>> >line handling in odd ways when powered up), and some are almost just a
>> >straight pipe through to the USB host with control line handling ideas
>> >tacked on to the side as an afterthought, if at all=2E
>> >
>> >There is no standard here, they all work differently, and even work
>> >differently across the same device type with just barely enough hints
>> >for us to determine what is going on=2E
>> >
>> >So don't worry about USB, if you throw that into the mix, all bets are
>> >off and you should NEVER rely on that=2E
>> >
>> >Remeber USB->serial was explicitly rejected by the USB standard group,
>> >only to have it come back in the "side door" through the spec process
>> >when it turned out that Microsoft hated having to write a zillion
>> >different vendor-specific drivers because the vendor provided ones kep=
t
>> >crashing user's machines=2E  So what we ended up with was "just enough=
" to
>> >make it through the spec process, and even then line signals are
>> >probably never tested so you can't rely on them=2E
>> >
>> >good luck!
>> >
>> >greg "this brought up too many bad memories" k-h
>>=20
>> Ugh=2E
>>=20
>> I have made it very clear that I am very aware that there is broken har=
dware=2E=20
>
>I would posit that there is NO "non-broken" usb->serial devices out
>there=2E  The closest I have seen was the old IO-Edgeport devices, but
>they were expensive and got bought out by some other company and in the
>end didn't succeed due to all of the "cheap" devices/chips out there
>that just did dumb tx/rx transfers over a fake serial connection=2E
>
>> What I'm trying to do is to deal with the (occasional) case of
>> *non*-broken hardware=2E Right now Linux breaks the non-broken hardware
>> for it, and I don't think the existence of broken hardware is a good
>> justification for that=2E
>
>No, but we have to handle both somehow=2E
>
>And given that we still get brand-new UART drivers sent to use every few
>months, there is just more and more "broken" hardware out there overall=
=2E
>
>Anyway, good luck coming up with a scheme to handle your crazy
>connections, I would push back and say "any device that treats a serial
>control line as a power signal is broken to start with" :)
>
>greg k-h

Yeah, well, I will certainly *not* argue with that one! Quite the contrary=
=2E=2E=2E *shudder*=2E

There are enough facepalms to go around, both on the DTE and DCE sides, an=
d I'm not in any shape, way, or form denying that=2E

Nor am I trying to boil the ocean here=2E I'm just trying to figure out ho=
w to make the situation a bit more flexible to try to at least reduce the a=
mount of brokenness we throw back in the face of the user=2E=20

The reason I brought up USB is that while RTS# briefly glitching on an act=
ual RS232 line is unlikely to actually make it through the driver, which wi=
ll have a cutoff of at most 10 MHz and usually much less, an ACM device rec=
eiving a SET_LINE_CONTROL message may react to it immediately, especially i=
f it is an emulated port=2E(*)

The same thing is true, of course, for "uart" lines, a=2Ek=2Ea=2E TTL or C=
MOS level serial, which have much higher bandwidth than any physical RS232 =
or RS485 drivers=2E

Incidentally, I'm not looking at this because of a huge need on my own par=
t; I'm doing it because it irked me to no end that glibc still hadn't imple=
mented support for the almost two decades old support in the Linux kernel f=
or arbitrary serial port speeds, and in the end I ended up Just Writing The=
 Code; but there as well I ended up having several discussions with the gli=
bc maintainers about how to deal with the unavoidable compromises involved =
in evolving one l the interfaces; the POSIX termios interface design from b=
ack in the '80s really caused some serious headaches=2E=20

There was fallout, as it exposed bugs in a bunch of software which had imp=
lemented their own hacks during the 17 years that glibc didn't provide any =
support for handling this=2E It gave me a *lot* of new insights in how vari=
ous applications in the field actually do things and what they have to do t=
o work around limitations in both hardware and software at the moment, and =
so I'm feeling kind of motivated to try to make these real life use cases a=
 little bit less obnoxious=2E

The thing with RTS# and DTR# came up when I started rooting around in gtkt=
erm's serial code probing code, but I had myself run into it using ESP32 mo=
dules=2E

Had I personally designed the ESP32 interface I would have used BREAK to p=
ulse reset instead of RTS#, but that would have required a capacitor and a =
diode, and omg that would have added *cost!*

(This is in fact exactly what I did when I implemented my own ACM device i=
n an FPGA, but that's a different story=2E)

As far as actual USB-to-serial devices are concerned, my *personal* experi=
ence with quite a few of them is that the line control signals are generall=
y quite reliable, and transmitting BREAK usually works OK; however, whether=
 *receiving* BREAK works is a crapshoot at the very best=2E

Then there are of course the ones that just lock up randomly, or seriously=
 glitch on the USB side, but that's an entirely different kettle of fish=2E

And you are most definitely right that not standardizing a USB to serial d=
evice class from the very beginning was a very bad mistake=2E At least now =
newer devices tend toward using ACM and advertise as "driverless"=2E It als=
o allows the rest of the USB descriptor to contain more useful information =
about the DCE, assuming it is a device that is physically bound to or integ=
rated in the DCE (virtual=2E)

I'm not saying you and Ted are *wrong*; you are most certainly not=2E What=
 I'm hoping for is a bit of pragmatism that would make at least some users'=
 lives a little easier=2E

None of this will, of course, help when the hardware itself is buggered to=
 the point that there is nothing we can do about it=2E I'm not trying to de=
al with anything like that=2E

Things that I have identified, at least in my opinion:

1=2E Opening a device for configuration as opposed to data streaming; in t=
he tty case that doesn't just improve the DTR# and RTS# issue but allows se=
tserial, configuring line disciplines and so on=2E

As I have said, this is application-specific intent, which is why I strong=
ly believe that it needs to be part of the open system call=2E I furthermor=
e believe that it would have use cases beyond ttys and serial ports, which =
is why I'm proposing a new open flag as opposed to a sysfs attribute, which=
 actually was my initial approach (yes, I have already prototyped some of t=
his, and as referenced before there is an existing patchset that was never =
merged=2E)

2=2E Currently the setserial configurables are available in sysfs, but *on=
ly* for UARTs, whereas TIOC[GS]SERIAL is at least available to all serial d=
evices=2E That code should presumably be hoisted into a higher layer; this =
shouldn't be too difficult=2E

3=2E The only way to determine the type of a tty driver is reading and par=
sing /proc/tty/drivers; that information is exported neither through ioctl =
nor sysfs=2E Exporting *that* through sysfs is probably the easiest of all =
the improvements=2E

4=2E There isn't a device-independent way to determine if a device is "rea=
l" (configured for hardware) or not without opening it and executing one of=
 the termios ioctls like TCGETS (returns -EIO if there isn't anything behin=
d it=2E) For a UART port it is possible to come up with an educated guess b=
ased on the aforementioned sysfs properties (does it have any kind of addre=
ss associated with it?), but seriously, should stty -a /dev/ttyS0 really gl=
itch RTS# and DTR# even though there is no intent of using the port for com=
munication?=20

Let me make it very clear that I'm *not* criticizing neither you, Ted, Ala=
n Cox nor anyone else who have been involved: on the contrary, you have don=
e an absolutely fantastic job making Linux work with all these pieces of ha=
rdware, each with various "interesting" properties=2E Nor am I criticizing =
the tty interface as it is: it is designed to allow both interactive termin=
al use and use for other purposes under program control, which is really an=
 astonishing level of flexibility=2E We have already shown that it can evol=
ve to meet new needs, which sometimes requires interface extensions =E2=80=
=93 like O_NOCTTY, O_NONBLOCK, CRTSCTS, termios2, and BOTHER=2E *And that i=
s perfectly okay=2E* If anything it is a strength=2E

And please do recognize that I have stated from the beginning that I expec=
t this to be a "best effort" on the part of kernel, not a guarantee=2E If t=
he hardware is too broken, the user gets to keep both pieces =E2=80=93 that=
's just reality=2E


