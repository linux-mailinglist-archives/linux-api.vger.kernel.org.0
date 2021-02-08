Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4852312EB3
	for <lists+linux-api@lfdr.de>; Mon,  8 Feb 2021 11:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbhBHKPm (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 8 Feb 2021 05:15:42 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:2828 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbhBHKOh (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 8 Feb 2021 05:14:37 -0500
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4DZ1xz00dlz13rjY;
        Mon,  8 Feb 2021 18:11:02 +0800 (CST)
Received: from dggpemm100012.china.huawei.com (7.185.36.212) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Mon, 8 Feb 2021 18:13:16 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggpemm100012.china.huawei.com (7.185.36.212) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2106.2; Mon, 8 Feb 2021 18:13:16 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.006;
 Mon, 8 Feb 2021 18:13:16 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
CC:     "Wangzhou (B)" <wangzhou1@hisilicon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>,
        "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
        "chensihang (A)" <chensihang1@hisilicon.com>
Subject: RE: [RFC PATCH v3 1/2] mempinfd: Add new syscall to provide memory
 pin
Thread-Topic: [RFC PATCH v3 1/2] mempinfd: Add new syscall to provide memory
 pin
Thread-Index: AQHW/SrsWWMRpilf2UC1Pz29QqsBVqpMsX2AgACQE1D//7IVAIAAi2xQ///nWQCAAKIUUA==
Date:   Mon, 8 Feb 2021 10:13:15 +0000
Message-ID: <fdee54b5ab91453d93d2f775ca2532d2@hisilicon.com>
References: <1612685884-19514-1-git-send-email-wangzhou1@hisilicon.com>
 <1612685884-19514-2-git-send-email-wangzhou1@hisilicon.com>
 <20210207213409.GL308988@casper.infradead.org>
 <f4b2d7db8a1047d9952cbbfaf9e27824@hisilicon.com>
 <20210208013056.GM308988@casper.infradead.org>
 <b4e2acc237e44ffe916135e96ad3ef20@hisilicon.com>
 <beb4dfb5-e9d2-a76c-f965-28cff5e4658b@redhat.com>
In-Reply-To: <beb4dfb5-e9d2-a76c-f965-28cff5e4658b@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.200.200]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogb3duZXItbGludXgtbW1A
a3ZhY2sub3JnIFttYWlsdG86b3duZXItbGludXgtbW1Aa3ZhY2sub3JnXSBPbiBCZWhhbGYgT2YN
Cj4gRGF2aWQgSGlsZGVuYnJhbmQNCj4gU2VudDogTW9uZGF5LCBGZWJydWFyeSA4LCAyMDIxIDk6
MjIgUE0NCj4gVG86IFNvbmcgQmFvIEh1YSAoQmFycnkgU29uZykgPHNvbmcuYmFvLmh1YUBoaXNp
bGljb24uY29tPjsgTWF0dGhldyBXaWxjb3gNCj4gPHdpbGx5QGluZnJhZGVhZC5vcmc+DQo+IENj
OiBXYW5nemhvdSAoQikgPHdhbmd6aG91MUBoaXNpbGljb24uY29tPjsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsNCj4gaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc7IGxpbnV4
LW1tQGt2YWNrLm9yZzsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBs
aW51eC1hcGlAdmdlci5rZXJuZWwub3JnOyBBbmRyZXcNCj4gTW9ydG9uIDxha3BtQGxpbnV4LWZv
dW5kYXRpb24ub3JnPjsgQWxleGFuZGVyIFZpcm8gPHZpcm9AemVuaXYubGludXgub3JnLnVrPjsN
Cj4gZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc7IGpnZ0B6aWVwZS5jYTsga2V2aW4udGlhbkBp
bnRlbC5jb207DQo+IGplYW4tcGhpbGlwcGVAbGluYXJvLm9yZzsgZXJpYy5hdWdlckByZWRoYXQu
Y29tOyBMaWd1b3podSAoS2VubmV0aCkNCj4gPGxpZ3Vvemh1QGhpc2lsaWNvbi5jb20+OyB6aGFu
Z2ZlaS5nYW9AbGluYXJvLm9yZzsgY2hlbnNpaGFuZyAoQSkNCj4gPGNoZW5zaWhhbmcxQGhpc2ls
aWNvbi5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIHYzIDEvMl0gbWVtcGluZmQ6IEFk
ZCBuZXcgc3lzY2FsbCB0byBwcm92aWRlIG1lbW9yeQ0KPiBwaW4NCj4gDQo+IE9uIDA4LjAyLjIx
IDAzOjI3LCBTb25nIEJhbyBIdWEgKEJhcnJ5IFNvbmcpIHdyb3RlOg0KPiA+DQo+ID4NCj4gPj4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogb3duZXItbGludXgtbW1Aa3Zh
Y2sub3JnIFttYWlsdG86b3duZXItbGludXgtbW1Aa3ZhY2sub3JnXSBPbiBCZWhhbGYNCj4gT2YN
Cj4gPj4gTWF0dGhldyBXaWxjb3gNCj4gPj4gU2VudDogTW9uZGF5LCBGZWJydWFyeSA4LCAyMDIx
IDI6MzEgUE0NCj4gPj4gVG86IFNvbmcgQmFvIEh1YSAoQmFycnkgU29uZykgPHNvbmcuYmFvLmh1
YUBoaXNpbGljb24uY29tPg0KPiA+PiBDYzogV2FuZ3pob3UgKEIpIDx3YW5nemhvdTFAaGlzaWxp
Y29uLmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4+IGlvbW11QGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnOyBsaW51eC1tbUBrdmFjay5vcmc7DQo+ID4+IGxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtYXBpQHZnZXIua2VybmVsLm9yZzsg
QW5kcmV3DQo+ID4+IE1vcnRvbiA8YWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZz47IEFsZXhhbmRl
ciBWaXJvDQo+IDx2aXJvQHplbml2LmxpbnV4Lm9yZy51az47DQo+ID4+IGdyZWdraEBsaW51eGZv
dW5kYXRpb24ub3JnOyBqZ2dAemllcGUuY2E7IGtldmluLnRpYW5AaW50ZWwuY29tOw0KPiA+PiBq
ZWFuLXBoaWxpcHBlQGxpbmFyby5vcmc7IGVyaWMuYXVnZXJAcmVkaGF0LmNvbTsgTGlndW96aHUg
KEtlbm5ldGgpDQo+ID4+IDxsaWd1b3podUBoaXNpbGljb24uY29tPjsgemhhbmdmZWkuZ2FvQGxp
bmFyby5vcmc7IGNoZW5zaWhhbmcgKEEpDQo+ID4+IDxjaGVuc2loYW5nMUBoaXNpbGljb24uY29t
Pg0KPiA+PiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCB2MyAxLzJdIG1lbXBpbmZkOiBBZGQgbmV3
IHN5c2NhbGwgdG8gcHJvdmlkZSBtZW1vcnkNCj4gPj4gcGluDQo+ID4+DQo+ID4+IE9uIFN1biwg
RmViIDA3LCAyMDIxIGF0IDEwOjI0OjI4UE0gKzAwMDAsIFNvbmcgQmFvIEh1YSAoQmFycnkgU29u
Zykgd3JvdGU6DQo+ID4+Pj4+IEluIGhpZ2gtcGVyZm9ybWFuY2UgSS9PIGNhc2VzLCBhY2NlbGVy
YXRvcnMgbWlnaHQgd2FudCB0byBwZXJmb3JtDQo+ID4+Pj4+IEkvTyBvbiBhIG1lbW9yeSB3aXRo
b3V0IElPIHBhZ2UgZmF1bHRzIHdoaWNoIGNhbiByZXN1bHQgaW4gZHJhbWF0aWNhbGx5DQo+ID4+
Pj4+IGluY3JlYXNlZCBsYXRlbmN5LiBDdXJyZW50IG1lbW9yeSByZWxhdGVkIEFQSXMgY291bGQg
bm90IGFjaGlldmUgdGhpcw0KPiA+Pj4+PiByZXF1aXJlbWVudCwgZS5nLiBtbG9jayBjYW4gb25s
eSBhdm9pZCBtZW1vcnkgdG8gc3dhcCB0byBiYWNrdXAgZGV2aWNlLA0KPiA+Pj4+PiBwYWdlIG1p
Z3JhdGlvbiBjYW4gc3RpbGwgdHJpZ2dlciBJTyBwYWdlIGZhdWx0Lg0KPiA+Pj4+DQo+ID4+Pj4g
V2VsbCAuLi4gd2UgaGF2ZSB0d28gcmVxdWlyZW1lbnRzLiAgVGhlIGFwcGxpY2F0aW9uIHdhbnRz
IHRvIG5vdCB0YWtlDQo+ID4+Pj4gcGFnZSBmYXVsdHMuICBUaGUgc3lzdGVtIHdhbnRzIHRvIG1v
dmUgdGhlIGFwcGxpY2F0aW9uIHRvIGEgZGlmZmVyZW50DQo+ID4+Pj4gTlVNQSBub2RlIGluIG9y
ZGVyIHRvIG9wdGltaXNlIG92ZXJhbGwgcGVyZm9ybWFuY2UuICBXaHkgc2hvdWxkIHRoZQ0KPiA+
Pj4+IGFwcGxpY2F0aW9uJ3MgZGVzaXJlcyB0YWtlIHByZWNlZGVuY2Ugb3ZlciB0aGUga2VybmVs
J3MgZGVzaXJlcz8gIEFuZCB3aHkNCj4gPj4+PiBzaG91bGQgaXQgYmUgZG9uZSB0aGlzIHdheSBy
YXRoZXIgdGhhbiBieSB0aGUgc3lzYWRtaW4gdXNpbmcgbnVtYWN0bCB0bw0KPiA+Pj4+IGxvY2sg
dGhlIGFwcGxpY2F0aW9uIHRvIGEgcGFydGljdWxhciBub2RlPw0KPiA+Pj4NCj4gPj4+IE5VTUEg
YmFsYW5jZXIgaXMganVzdCBvbmUgb2YgbWFueSByZWFzb25zIGZvciBwYWdlIG1pZ3JhdGlvbi4g
RXZlbiBvbmUNCj4gPj4+IHNpbXBsZSBhbGxvY19wYWdlcygpIGNhbiBjYXVzZSBtZW1vcnkgbWln
cmF0aW9uIGluIGp1c3Qgc2luZ2xlIE5VTUENCj4gPj4+IG5vZGUgb3IgVU1BIHN5c3RlbS4NCj4g
Pj4+DQo+ID4+PiBUaGUgb3RoZXIgcmVhc29ucyBmb3IgcGFnZSBtaWdyYXRpb24gaW5jbHVkZSBi
dXQgYXJlIG5vdCBsaW1pdGVkIHRvOg0KPiA+Pj4gKiBtZW1vcnkgbW92ZSBkdWUgdG8gQ01BDQo+
ID4+PiAqIG1lbW9yeSBtb3ZlIGR1ZSB0byBodWdlIHBhZ2VzIGNyZWF0aW9uDQo+ID4+Pg0KPiA+
Pj4gSGFyZGx5IHdlIGNhbiBhc2sgdXNlcnMgdG8gZGlzYWJsZSB0aGUgQ09NUEFDVElPTiwgQ01B
IGFuZCBIdWdlIFBhZ2UNCj4gPj4+IGluIHRoZSB3aG9sZSBzeXN0ZW0uDQo+ID4+DQo+ID4+IFlv
dSdyZSBkb2RnaW5nIHRoZSBxdWVzdGlvbi4gIFNob3VsZCB0aGUgQ01BIGFsbG9jYXRpb24gZmFp
bCBiZWNhdXNlDQo+ID4+IGFub3RoZXIgYXBwbGljYXRpb24gaXMgdXNpbmcgU1ZBPw0KPiA+Pg0K
PiA+PiBJIHdvdWxkIHNheSBuby4NCj4gPg0KPiA+IEkgd291bGQgc2F5IG5vIGFzIHdlbGwuDQo+
ID4NCj4gPiBXaGlsZSBJT01NVSBpcyBlbmFibGVkLCBDTUEgYWxtb3N0IGhhcyBvbmUgdXNlciBv
bmx5OiBJT01NVSBkcml2ZXINCj4gPiBhcyBvdGhlciBkcml2ZXJzIHdpbGwgZGVwZW5kIG9uIGlv
bW11IHRvIHVzZSBub24tY29udGlndW91cyBtZW1vcnkNCj4gPiB0aG91Z2ggdGhleSBhcmUgc3Rp
bGwgY2FsbGluZyBkbWFfYWxsb2NfY29oZXJlbnQoKS4NCj4gPg0KPiA+IEluIGlvbW11IGRyaXZl
ciwgZG1hX2FsbG9jX2NvaGVyZW50IGlzIGNhbGxlZCBkdXJpbmcgaW5pdGlhbGl6YXRpb24NCj4g
PiBhbmQgdGhlcmUgaXMgbm8gbmV3IGFsbG9jYXRpb24gYWZ0ZXJ3YXJkcy4gU28gaXQgd291bGRu
J3QgY2F1c2UNCj4gPiBydW50aW1lIGltcGFjdCBvbiBTVkEgcGVyZm9ybWFuY2UuIEV2ZW4gdGhl
cmUgaXMgbmV3IGFsbG9jYXRpb25zLA0KPiA+IENNQSB3aWxsIGZhbGwgYmFjayB0byBnZW5lcmFs
IGFsbG9jX3BhZ2VzKCkgYW5kIGlvbW11IGRyaXZlcnMgYXJlDQo+ID4gYWxtb3N0IGFsbG9jYXRp
bmcgc21hbGwgbWVtb3J5IGZvciBjb21tYW5kIHF1ZXVlcy4NCj4gPg0KPiA+IFNvIEkgd291bGQg
c2F5IGdlbmVyYWwgY29tcG91bmQgcGFnZXMsIGh1Z2UgcGFnZXMsIGVzcGVjaWFsbHkNCj4gPiB0
cmFuc3BhcmVudCBodWdlIHBhZ2VzLCB3b3VsZCBiZSBiaWdnZXIgY29uY2VybnMgdGhhbiBDTUEg
Zm9yDQo+ID4gaW50ZXJuYWwgcGFnZSBtaWdyYXRpb24gd2l0aGluIG9uZSBOVU1BLg0KPiA+DQo+
ID4gTm90IGxpa2UgQ01BLCBnZW5lcmFsIGFsbG9jX3BhZ2VzKCkgY2FuIGdldCBtZW1vcnkgYnkg
bW92aW5nDQo+ID4gcGFnZXMgb3RoZXIgdGhhbiB0aG9zZSBwaW5uZWQuDQo+ID4NCj4gPiBBbmQg
dGhlcmUgaXMgbm8gZ3VhcmFudGVlIHdlIGNhbiBhbHdheXMgYmluZCB0aGUgbWVtb3J5IG9mDQo+
ID4gU1ZBIGFwcGxpY2F0aW9ucyB0byBzaW5nbGUgb25lIE5VTUEsIHNvIE5VTUEgYmFsYW5jaW5n
IGlzDQo+ID4gc3RpbGwgYSBjb25jZXJuLg0KPiA+DQo+ID4gQnV0IEkgYWdyZWUgd2UgbmVlZCBh
IHdheSB0byBtYWtlIENNQSBzdWNjZXNzIHdoaWxlIHRoZSB1c2Vyc3BhY2UNCj4gPiBwYWdlcyBh
cmUgcGlubmVkLiBTaW5jZSBwaW4gaGFzIGJlZW4gdmlyYWwgaW4gbWFueSBkcml2ZXJzLCBJDQo+
ID4gYXNzdW1lIHRoZXJlIGlzIGEgd2F5IHRvIGhhbmRsZSB0aGlzLiBPdGhlcndpc2UsIEFQSXMg
bGlrZQ0KPiA+IFY0TDJfTUVNT1JZX1VTRVJQVFJbMV0gd2lsbCBwb3NzaWJseSBtYWtlIENNQSBm
YWlsIGFzIHRoZXJlDQo+ID4gaXMgbm8gZ3VhcmFudGVlIHRoYXQgdXNlcnNzcGFjZSB3aWxsIGFs
bG9jYXRlIHVubW92YWJsZSBtZW1vcnkNCj4gPiBhbmQgdGhlcmUgaXMgbm8gZ3VhcmFudGVlIHRo
ZSBmYWxsYmFjayBwYXRoLSBhbGxvY19wYWdlcygpIGNhbg0KPiA+IHN1Y2NlZWQgd2hpbGUgYWxs
b2NhdGluZyBiaWcgbWVtb3J5Lg0KPiA+DQo+IA0KPiBMb25nIHRlcm0gcGlubmluZ3MgY2Fubm90
IGdvIG9udG8gQ01BLXJlc2VydmVkIG1lbW9yeSwgYW5kIHRoZXJlIGlzDQo+IHNpbWlsYXIgd29y
ayB0byBhbHNvIGZpeCBaT05FX01PVkFCTEUgaW4gdGhhdCByZWdhcmQuDQo+IA0KPiBodHRwczov
L2xrbWwua2VybmVsLm9yZy9yLzIwMjEwMTI1MTk0NzUxLjEyNzUzMTYtMS1wYXNoYS50YXRhc2hp
bkBzb2xlZW4uYw0KPiBvbQ0KPiANCj4gT25lIG9mIHRoZSByZWFzb25zIEkgZGV0ZXN0IHVzaW5n
IGxvbmcgdGVybSBwaW5uaW5nIG9mIHBhZ2VzIHdoZXJlIGl0DQo+IGNvdWxkIGJlIGF2b2lkZWQu
IFRha2UgVkZJTyBhbmQgUkRNQSBhcyBhbiBleGFtcGxlOiB0aGVzZSB0aGluZ3MNCj4gY3VycmVu
dGx5IGNhbid0IHdvcmsgd2l0aG91dCB0aGVtLg0KPiANCj4gV2hhdCBJIHJlYWQgaGVyZTogIkRN
QSBwZXJmb3JtYW5jZSB3aWxsIGJlIGFmZmVjdGVkIHNldmVyZWx5Ii4gVGhhdCBkb2VzDQo+IG5v
dCBzb3VuZCBsaWtlIGEgY29tcGVsbGluZyBhcmd1bWVudCB0byBtZSBmb3IgbG9uZyB0ZXJtIHBp
bm5pbmdzLg0KPiBQbGVhc2UgZmluZCBhbm90aGVyIHdheSB0byBhY2hpZXZlIHRoZSBzYW1lIGdv
YWwgd2l0aG91dCBsb25nIHRlcm0NCj4gcGlubmluZ3MgY29udHJvbGxlZCBieSB1c2VyIHNwYWNl
IC0gZS5nLiwgY29udHJvbGxpbmcgd2hlbiBtaWdyYXRpb24NCj4gYWN0dWFsbHkgaGFwcGVucy4N
Cj4gDQo+IEZvciBleGFtcGxlLCBDTUEvYWxsb2NfY29udGlnX3JhbmdlKCkvbWVtb3J5IHVucGx1
ZyBhcmUgY29ybmVyIGNhc2VzDQo+IHRoYXQgaGFwcGVuIHJhcmVseSwgeW91IHNob3VsZG4ndCBo
YXZlIHRvIHdvcnJ5IGFib3V0IHRoZW0gbWVzc2luZyB3aXRoDQo+IHlvdXIgRE1BIHBlcmZvcm1h
bmNlLg0KDQpJIGFncmVlIENNQS9hbGxvY19jb250aWdfcmFuZ2UoKS9tZW1vcnkgdW5wbHVnIHdv
dWxkIGJlIGNvcm5lciBjYXNlcywNCnRoZSBtYWpvciBjYXNlcyB3b3VsZCBiZSBUSFAsIE5VTUEg
YmFsYW5jaW5nIHdoaWxlIHdlIGNvdWxkIHRvdGFsbHkNCmRpc2FibGUgdGhlbSBidXQgaXQgc2Vl
bXMgaW5zZW5zaWJsZSB0byBkbyB0aGF0IG9ubHkgYmVjYXVzZSB0aGVyZSBpcw0KYSBwcm9jZXNz
IHVzaW5nIFNWQSBpbiB0aGUgc3lzdGVtLg0KDQo+IA0KPiAtLQ0KPiBUaGFua3MsDQo+IA0KPiBE
YXZpZCAvIGRoaWxkZW5iDQoNClRoYW5rcw0KQmFycnkNCg0K
