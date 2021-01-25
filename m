Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10E4130279D
	for <lists+linux-api@lfdr.de>; Mon, 25 Jan 2021 17:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730631AbhAYQQg (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 25 Jan 2021 11:16:36 -0500
Received: from mail.adebahr.de ([185.66.179.123]:50904 "EHLO mail.adebahr.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730623AbhAYQQT (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 25 Jan 2021 11:16:19 -0500
X-Greylist: delayed 536 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Jan 2021 11:16:17 EST
Received: from localhost (localhost [127.0.0.1])
        by mail.adebahr.de (Postfix) with ESMTP id 3829B601EBB17;
        Mon, 25 Jan 2021 17:06:27 +0100 (CET)
Authentication-Results: mail.adebahr.de (amavisd-new);
        dkim=pass (1024-bit key) reason="pass (just generated, assumed good)"
        header.d=smo.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=smo.de; h=
        content-transfer-encoding:content-type:content-type:in-reply-to
        :mime-version:user-agent:date:date:message-id:from:from
        :references:subject:subject; s=mail; t=1611590787; x=1613405188;
         bh=0Hu2jGMxMxqNRTowysPP+4NjmcjZaJxZPVp9ZQ8qz9o=; b=JTARFS9nruyr
        /0klbiOGwFbVfQQM/Yb4NXQ7P6YhKhZ3a+kPHjeKkGLZ+k0asqYi9JzlNtc4X02I
        +dKJw6fgfOzunta/ad47ZNPkj3uLFGO+FVXLxQRYt7Bz2Sq3tiSC2CcwJoYD4RFU
        hy3wTq6XOdwCkTWiUFgW0mOk59QAIko=
Received: from mail.adebahr.de ([127.0.0.1])
        by localhost (mail.adebahr.de [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id ntZw7qQmOo-3; Mon, 25 Jan 2021 17:06:27 +0100 (CET)
Received: from [192.168.153.201] (pd95154e8.dip0.t-ipconnect.de [217.81.84.232])
        by mail.adebahr.de (Postfix) with ESMTPSA id A5CF760084C5C;
        Mon, 25 Jan 2021 17:06:24 +0100 (CET)
Subject: Re: [PATCH v3 (resend)] tee: Add -q, --quiet, --silent option to not
 write to stdout
To:     Alejandro Colomar <alx.manpages@gmail.com>,
        Bernhard Voelker <mail@bernhard-voelker.de>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Christian Groessler <chris@groessler.org>,
        =?UTF-8?Q?P=c3=a1draig_Brady?= <P@draigbrady.com>,
        Coreutils <coreutils@gnu.org>,
        William Ahern <william@25thandclement.com>,
        Erik Auerswald <auerswal@unix-ag.uni-kl.de>,
        Eric Pruitt <eric.pruitt@gmail.com>,
        Jeffrey Walton <noloader@gmail.com>
Cc:     Michael Kerrisk <mtk.manpages@gmail.com>,
        Fabrice BAUZAC <noon@mykolab.com>, tech@openbsd.org,
        freebsd-hackers@freebsd.org, linux-api@vger.kernel.org,
        juli@clockworksquid.com, ed@nuxi.nl, oshogbo@freebsd.org
References: <1f8ce444-35e2-56a7-dbd1-34e885372b11@gmail.com>
 <20210124121845.38293-1-alx.manpages@gmail.com>
From:   Philipp-Joachim Ost <pj@smo.de>
Message-ID: <aa519ecf-b062-3100-f76f-c51c4ca8f497@smo.de>
Date:   Mon, 25 Jan 2021 17:06:24 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.4
MIME-Version: 1.0
In-Reply-To: <20210124121845.38293-1-alx.manpages@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Am 24.01.2021 um 13:18 schrieb Alejandro Colomar:
> This is useful for using tee to just write to a file,
> at the end of a pipeline,
> without having to redirect to /dev/null
> 
> Example:
> 
> echo 'foo' | sudo tee -q /etc/foo;
> 
> is equivalent to the old (and ugly)
> 
> echo 'foo' | sudo tee /etc/foo >/dev/null;

Why don't you just do

echo foo > /etc/foo

or

sudo sh -c 'echo foo > /etc/foo' ?

I don't normally use sudo, so there might be some better way of using it.

Kind regards,
Philipp
