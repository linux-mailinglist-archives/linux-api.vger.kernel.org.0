Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9C310E2D5
	for <lists+linux-api@lfdr.de>; Sun,  1 Dec 2019 19:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfLASOK (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 1 Dec 2019 13:14:10 -0500
Received: from mtax.cdmx.gob.mx ([187.141.35.197]:14200 "EHLO mtax.cdmx.gob.mx"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbfLASOK (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Sun, 1 Dec 2019 13:14:10 -0500
X-Greylist: delayed 6330 seconds by postgrey-1.27 at vger.kernel.org; Sun, 01 Dec 2019 13:14:09 EST
X-NAI-Header: Modified by McAfee Email Gateway (4500)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cdmx.gob.mx; s=72359050-3965-11E6-920A-0192F7A2F08E;
        t=1575217509; h=DKIM-Filter:X-Virus-Scanned:
         Content-Type:MIME-Version:Content-Transfer-Encoding:
         Content-Description:Subject:To:From:Date:Message-Id:
         X-AnalysisOut:X-AnalysisOut:X-AnalysisOut:
         X-AnalysisOut:X-AnalysisOut:X-SAAS-TrackingID:
         X-NAI-Spam-Flag:X-NAI-Spam-Threshold:X-NAI-Spam-Score:
         X-NAI-Spam-Rules:X-NAI-Spam-Version; bh=M
        8rWdUYQ57RAYAgTWJQ4Rsch0kO0UXllaAVDzocOs4
        8=; b=vL6BjzY0qcULufC3r9xeRBUGzsVyJxGoNvhJxWrH71h4
        8MBUh1pKjFBPvqxtmJgtcHMIzMaDJTF02HsMCiPij8dKmjFa9y
        JPhUnfEYyXR6lHy+KPuMMk4Nl34mDMcoVQaXdBP6kAP+wJkwW9
        n6f3dGWm1ieHLWIJ8NTdcQH8D6k=
Received: from cdmx.gob.mx (correo.cdmx.gob.mx [10.250.108.150]) by mtax.cdmx.gob.mx with smtp
        (TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
         id 1dee_5d24_1cda6e7e_a5a7_4a4d_bf79_86a975ef90a1;
        Sun, 01 Dec 2019 10:25:08 -0600
Received: from localhost (localhost [127.0.0.1])
        by cdmx.gob.mx (Postfix) with ESMTP id BFC2F1E2CB5;
        Sun,  1 Dec 2019 10:17:31 -0600 (CST)
Received: from cdmx.gob.mx ([127.0.0.1])
        by localhost (cdmx.gob.mx [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id nsZnrq9bkWxX; Sun,  1 Dec 2019 10:17:31 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
        by cdmx.gob.mx (Postfix) with ESMTP id CE1D91E2C96;
        Sun,  1 Dec 2019 10:12:31 -0600 (CST)
DKIM-Filter: OpenDKIM Filter v2.9.2 cdmx.gob.mx CE1D91E2C96
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cdmx.gob.mx;
        s=72359050-3965-11E6-920A-0192F7A2F08E; t=1575216751;
        bh=M8rWdUYQ57RAYAgTWJQ4Rsch0kO0UXllaAVDzocOs48=;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:To:
         From:Date:Message-Id;
        b=VlSiXfh1hhiZ8R8vffGnNS0Ya0y3gjyxQWfUQhtC7LC4XNYfPBQe6klB12P6xNkCc
         V6o1gyUThuMYzMQNWth358fewY/F7CAKXpiPZXXaETw+DlSGFmAHeBVx/ft2v27NSx
         bptpqY2X4i/GQVncWjt9Rewv0HJFtFKyVD3ZEc3o=
X-Virus-Scanned: amavisd-new at cdmx.gob.mx
Received: from cdmx.gob.mx ([127.0.0.1])
        by localhost (cdmx.gob.mx [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 1vxU-lDGrGBT; Sun,  1 Dec 2019 10:12:31 -0600 (CST)
Received: from [192.168.0.104] (unknown [188.125.168.160])
        by cdmx.gob.mx (Postfix) with ESMTPSA id 2BB671E2CBB;
        Sun,  1 Dec 2019 10:03:06 -0600 (CST)
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Congratulations
To:     Recipients <aac-styfe@cdmx.gob.mx>
From:   "Bishop Johnr" <aac-styfe@cdmx.gob.mx>
Date:   Sun, 01 Dec 2019 17:02:59 +0100
Message-Id: <20191201160307.2BB671E2CBB@cdmx.gob.mx>
X-AnalysisOut: [v=2.2 cv=Rf/gMxlv c=1 sm=1 tr=0 p=6K-Ig8iNAUou4E5wYCEA:9 p]
X-AnalysisOut: [=zRI05YRXt28A:10 a=T6zFoIZ12MK39YzkfxrL7A==:117 a=9152RP8M]
X-AnalysisOut: [6GQqDhC/mI/QXQ==:17 a=8nJEP1OIZ-IA:10 a=pxVhFHJ0LMsA:10 a=]
X-AnalysisOut: [pGLkceISAAAA:8 a=wPNLvfGTeEIA:10 a=M8O0W8wq6qAA:10 a=Ygvjr]
X-AnalysisOut: [iKHvHXA2FhpO6d-:22]
X-SAAS-TrackingID: 369e3ed5.0.105103313.00-2274.176703483.s12p02m011.mxlogic.net
X-NAI-Spam-Flag: NO
X-NAI-Spam-Threshold: 3
X-NAI-Spam-Score: -5000
X-NAI-Spam-Rules: 1 Rules triggered
        WHITELISTED=-5000
X-NAI-Spam-Version: 2.3.0.9418 : core <6686> : inlines <7165> : streams
 <1840193> : uri <2949748>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Money was donated to you by Mr and Mrs Allen and Violet Large, just contact=
 them with this email for more information =


EMail: allenandvioletlargeaward@gmail.com
