Return-Path: <linux-api+bounces-5279-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B53C5EF6A
	for <lists+linux-api@lfdr.de>; Fri, 14 Nov 2025 20:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9562B361EB2
	for <lists+linux-api@lfdr.de>; Fri, 14 Nov 2025 18:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4152DECD8;
	Fri, 14 Nov 2025 18:49:24 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48435221F1F;
	Fri, 14 Nov 2025 18:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763146164; cv=none; b=eaziBuA9nxjVV4TrntLFH7cXw9g/Dnmtv4/jI+LusIRF+M/jSWg6gzOED4p11H3lMX/9TYiq4XYMjWVSx8wOAr7hsCn2FTpe/sEhXXwA17ZDNHaNFrGjTjSrh9BUjQXkmKrwNIIhM1Y7xT9osPT3mKddWkojXDt+ERLBPCPJwGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763146164; c=relaxed/simple;
	bh=4eLACvnkLgUeP2/LMlxkKOLC1GDRxIqhi6T83Su29kE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XcMO0wSymG4bo22OLrC0E1vgCyiXLV3K0xvbE5t9PcOkog/+04ogULZGV4fDr9ECIOlBq1glZn1soQ6PGJhu4RpQCp+Gm2o2XpHPG3HPbZdi2fa+9bn0pixDyLe5T+K1tvakuHwtwXiGKs3dilPmTffkjhSnIv+VVPso829A7hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 74E7D92009C; Fri, 14 Nov 2025 19:49:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 6E11C92009B;
	Fri, 14 Nov 2025 18:49:09 +0000 (GMT)
Date: Fri, 14 Nov 2025 18:49:09 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: Greg KH <gregkh@linuxfoundation.org>, Theodore Ts'o <tytso@mit.edu>, 
    Maarten Brock <Maarten.Brock@sttls.nl>, 
    "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, 
    "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: RFC: Serial port DTR/RTS - O_<something>
In-Reply-To: <14b1bc5c-83ac-431f-a53b-14872024b969@zytor.com>
Message-ID: <alpine.DEB.2.21.2511141836130.47194@angie.orcam.me.uk>
References: <ADB50E23-DC8B-43D0-A345-E10396A3DFD4@zytor.com> <AMBPR05MB11925DA076098B05E418BF64283CEA@AMBPR05MB11925.eurprd05.prod.outlook.com> <20251110201933.GH2988753@mit.edu> <0F8021E8-F288-4669-8195-9948844E36FD@zytor.com> <20251111035143.GJ2988753@mit.edu>
 <D4AF3E24-8698-4EEC-9D52-655D69897111@zytor.com> <2025111214-doily-anyway-b24b@gregkh> <6DBB5931-ACD4-4174-9FCE-96C45FFC4603@zytor.com> <2025111241-domestic-moonstone-f75f@gregkh> <DD67C0CF-D330-4D40-B610-FD3EB7AA0218@zytor.com> <2025111227-equipment-magnetism-1443@gregkh>
 <14b1bc5c-83ac-431f-a53b-14872024b969@zytor.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 13 Nov 2025, H. Peter Anvin wrote:

> > I think this is going to be the most difficult.  I don't remember why I
> > rejected the old submission, but maybe it would have modified the
> > existing behaviour?  A new open flag "O_DO_NOT_TOUCH_ANYTHING" might be
> > the simplest?
> > 
> 
> Okay, to I'm going to toss out a couple suggestions for naming:
> 
> 	O_(PRE|FOR|N|NO)?(INIT|CONFIG|START)(DEV|HW|IO)?
> 	O_(NO?RESET|PREPARE)(DEV|HW|IO)?
> 	O_NO?TOUCH
> 	O_NYET ("not yet")
> 	
> I think my personal preference at the moment is either O_NYET or O_PRECONFIG
> or O_NYET; although it is perhaps a bit more "use case centric" than "what
> actual effect it has" I think it might be clearer.  A -DEV, -HW or -IO suffix
> would seem to needlessly preclude it being used for future similar use cases
> for files that are not device nodes.

 Hmm, I'm inconvinced about any of these.

 How about O_FDONLY, to reflect that you are after a file descriptor only 
with no further actions at open time while avoiding the ambiguity of names 
such as CONFIG vs NOCONFIG or speaking more broadly implying any specific 
intent of use at all such as with CONFIG/INIT/PREPARE/RESET/whatever?

 I think O_FDONLY is concise, easy to spell/say/remember, and fits the 
purpose.  Your call!

  Maciej

